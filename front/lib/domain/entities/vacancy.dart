class Vacancy {
  final String name;
  final String description;
  final String area;
  final VacancySalary salary;
  final List<String> skills;
  final VacancyEmployer employer;
  final String publishedAt;
  final String url;

  Vacancy({required this.name, required this.description, 
          required this.area, required this.salary, 
          required this.skills, required this.employer, 
          required this.publishedAt, required this.url});

  factory Vacancy.fromJson(Map<String, dynamic> json) {
    return Vacancy(
      name: json['name'],
      description: json['description'],
      area: json['area_name'],
      salary: VacancySalary(json['salary']['from'], json['salary']['to'], json['salary']['currency']),
      skills: List<String>.from(json['skills']),
      employer: VacancyEmployer(json['employer']['name'], json['employer']['logo_url']),
      publishedAt: json['published_at'],
      url: json['url']
    );
  }
}

class VacancySalary {
  final double? from;
  final double? to;
  final String? currency;

  VacancySalary(this.from, this.to, this.currency);
}

class VacancyEmployer {
  final String? name;
  final String? logoUrl;

  VacancyEmployer(this.name, this.logoUrl);
}