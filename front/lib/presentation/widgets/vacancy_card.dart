import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/domain/entities/vacancy.dart';
import 'package:front/presentation/constants/colors.dart';
import 'package:front/presentation/constants/texts.dart';
import 'package:url_launcher/url_launcher.dart';


class VacancyCard extends StatefulWidget {
  final Vacancy vacancy;
  const VacancyCard({super.key, required this.vacancy});

  @override
  State<VacancyCard> createState() => _VacancyCardState();
}

class _VacancyCardState extends State<VacancyCard> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  Widget? getSalaryText(){
    final text = widget.vacancy.salary.from != null ? "от ${widget.vacancy.salary.from}" : "";
    if (widget.vacancy.salary.to != null){
      return Text("$text до ${widget.vacancy.salary.to} ${widget.vacancy.salary.currency}", style: TextStyles.subtitle);
    }
    if (widget.vacancy.salary.from != null){
      return Text("$text ${widget.vacancy.salary.currency}", style: TextStyles.subtitle);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Material(
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            hoverColor: Color.lerp(AppColors.primaryLight, Colors.white, 0.85),
            hoverDuration: const Duration(milliseconds: 150),
            onTap: () async {
              final url = Uri.parse(widget.vacancy.url);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Не удалось открыть ссылку')),
                );
              }
            },
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 8),
                    Flexible(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryLight,
                            ),
                            child: Text(widget.vacancy.name, style: TextStyles.title.copyWith(color: Colors.white)),
                          ),
                          getSalaryText() ?? const SizedBox(),
                          Text(widget.vacancy.employer.name == null ? "Не указано": widget.vacancy.employer.name!, 
                            style: TextStyles.subtitle),
                          Text(widget.vacancy.area, style: TextStyles.description),
                          Text(widget.vacancy.publishedAt, style: TextStyles.description),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30,),
                    Flexible(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Описание", style: TextStyles.subtitle),
                          const SizedBox(height: 10),
                          Text(
                            widget.vacancy.description, 
                            style: TextStyles.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 5,
                          ),
                          if (widget.vacancy.skills.length > 1)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Text("Навыки", style: TextStyles.subtitle),
                                const SizedBox(height: 10),
                                Text(widget.vacancy.skills.join(", "), style: TextStyles.description, overflow: TextOverflow.ellipsis, maxLines: 2),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}