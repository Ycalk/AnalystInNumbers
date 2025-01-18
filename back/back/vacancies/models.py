from datetime import datetime
import re

class Vacancy:
    class VacancySalary:
        def __init__ (self, salary_from: float, salary_to: float, currency: str):
            self.salary_from = salary_from
            self.salary_to = salary_to
            self.currency = currency
        
        @staticmethod
        def from_json(json):
            if ("salary" not in json) or (json["salary"] == None):
                return Vacancy.VacancySalary(None, None, None)
            return Vacancy.VacancySalary(json["salary"]["from"], json["salary"]["to"], json["salary"]["currency"])
        
        def to_json(self):
            return {"from": self.salary_from, "to": self.salary_to, "currency": self.currency}
    
    class VacancyEmployer:
        def __init__(self, employer_name: str, logo_url: str):
            self.employer_name = employer_name
            self.logo_url = logo_url
        
        @staticmethod
        def from_json(json):
            if ("employer" not in json) or (json["employer"] == None):
                return Vacancy.VacancyEmployer(None, None)
            try:
                logo_url = json["employer"]["logo_urls"]["240"]
            except Exception as _:
                logo_url = None
            return Vacancy.VacancyEmployer(json["employer"]["name"], logo_url)
        
        def to_json(self):
            return {"name": self.employer_name, "logo_url": self.logo_url}
            
    def __init__(self, name: str, salary: VacancySalary, 
                 description: str, skills: list[str],
                 employer: VacancyEmployer, area_name: str, published_at: str,
                 vacancy_url: str):
        self.name = name
        self.salary = salary
        self.description = description
        self.skills = skills
        self.employer = employer
        self.area_name = area_name
        self.published_at = published_at
        self.vacancy_url = vacancy_url
    
    @staticmethod
    def from_json(json: dict):
        return Vacancy(
            name=json["name"] if "name" in json else "",
            salary=Vacancy.VacancySalary.from_json(json),
            description=Vacancy.remove_tags(json["description"]) if "description" in json else "",
            skills=[skill["name"] for skill in json["key_skills"]] if "key_skills" in json else [],
            employer=Vacancy.VacancyEmployer.from_json(json),
            area_name=json["area"]["name"] if "area" in json else "",
            published_at=datetime.strptime(json["published_at"], "%Y-%m-%dT%H:%M:%S%z").strftime("%d %B %Y, %H:%M %Z"),
            vacancy_url=json["alternate_url"]
        )
    
    def to_json(self) -> dict:
        return {
            "name": self.name,
            "salary": self.salary.to_json(),
            "description": self.description,
            "skills": self.skills,
            "employer": self.employer.to_json(),
            "area_name": self.area_name,
            "published_at": self.published_at,
            "url": self.vacancy_url
        }

    @staticmethod
    def remove_tags(s: str) -> str:
        return re.sub(r"<.*?>", "", s)
