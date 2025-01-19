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
      duration: const Duration(milliseconds: 300),
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
    final text1 = widget.vacancy.salary.from != null ? "от ${widget.vacancy.salary.from}" : "";
    final text2 = widget.vacancy.salary.to != null ? "до ${widget.vacancy.salary.to}" : "";
    final text = text1 + (text1 == "" ? "" : " ") + text2;
    if (text == ""){
      return null;
    }
    return Text("$text ${widget.vacancy.salary.currency ?? ''}", style: TextStyles.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return _buildDesktopLayout();
          } else if (constraints.maxWidth > 800) {
            return _buildTabletLayout();
          } else {
            return _buildMobileLayout();
          }
        },
      ),
    );
  }

  Widget _buildDesktopLayout(){
    return Material(
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
          margin: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                    getSalaryText() ?? const SizedBox.shrink(),
                    Text(widget.vacancy.employer.name == null ? "Не указано": widget.vacancy.employer.name!, 
                      style: TextStyles.description),
                    const SizedBox(height: 10,),
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
                      style: TextStyles.description.copyWith(
                        overflow: TextOverflow.ellipsis
                      ),
                      maxLines: 5,
                    ),
                    if (widget.vacancy.skills.length > 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text("Навыки", style: TextStyles.subtitle),
                          const SizedBox(height: 10),
                          Text(widget.vacancy.skills.join(", "), 
                            style: TextStyles.description.copyWith(
                              overflow: TextOverflow.ellipsis
                            ), 
                          maxLines: 2),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletLayout(){
    return Material(
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
          margin: const EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
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
                      style: TextStyles.description),
                    const SizedBox(height: 10,),
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
                      style: TextStyles.description.copyWith(
                        overflow: TextOverflow.ellipsis
                      ),
                      maxLines: 4,
                    ),
                    if (widget.vacancy.skills.length > 1)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text("Навыки", style: TextStyles.subtitle),
                          const SizedBox(height: 10),
                          Text(widget.vacancy.skills.join(", "), 
                            style: TextStyles.description.copyWith(
                              overflow: TextOverflow.ellipsis
                            ), 
                          maxLines: 2),
                        ],
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout(){
    return Material(
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
          margin: const EdgeInsets.all(30),
          child: Wrap(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
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
                    style: TextStyles.description),
                  const SizedBox(height: 10,),
                  Text(widget.vacancy.area, style: TextStyles.description),
                  Text(widget.vacancy.publishedAt, style: TextStyles.description),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30,),
                  Text("Описание", style: TextStyles.subtitle),
                  const SizedBox(height: 10),
                  Text(
                    widget.vacancy.description, 
                    style: TextStyles.description.copyWith(
                      overflow: TextOverflow.ellipsis
                    ),
                    maxLines: 5,
                  ),
                  if (widget.vacancy.skills.length > 1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Text("Навыки", style: TextStyles.subtitle),
                        const SizedBox(height: 10),
                        Text(widget.vacancy.skills.join(", "), 
                          style: TextStyles.description.copyWith(
                            overflow: TextOverflow.ellipsis
                          ), 
                        maxLines: 2),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}