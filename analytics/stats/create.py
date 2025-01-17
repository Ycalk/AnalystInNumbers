import pandas as pd

class CreateStatistics:
    MIN_SALARY = 1000
    MAX_SALARY = 10000000
    VALID_AREA = 0.001
        
    def __init__(self, prepared_data: pd.DataFrame, out_folder):
        self.data = prepared_data
        self.out_folder = out_folder
    
    def create_year_column(data: pd.DataFrame) -> pd.DataFrame:
        data['published_at'] = pd.to_datetime(data['published_at'], errors='coerce', utc=True)
        data = data.dropna(subset=['salary', 'published_at'])
        data['year'] = data['published_at'].dt.year
        return data
    
    def salary_by_year(self, out_path):
        data = self.data.copy().dropna(subset=['salary', 'published_at'])
        
        data['salary'] = pd.to_numeric(data['salary'], errors='coerce')
        data = CreateStatistics.create_year_column(data)
        
        data : pd.DataFrame = data[(data['salary'] >= CreateStatistics.MIN_SALARY) & 
                    (data['salary'] <= CreateStatistics.MAX_SALARY)]
        
        salary_trend = data.groupby('year')['salary'].mean().reset_index()
        salary_trend.columns = ['year', 'average_salary']
        salary_trend.sort_values(by='year').rename(columns={'average_salary': 'salary'}).to_csv(out_path, index=False)
    
    def count_by_year(self, out_path):
        data = self.data.copy().dropna(subset=['published_at'])
        data = CreateStatistics.create_year_column(data)
        
        count_by_year = data.groupby('year')['salary'].count().reset_index()
        count_by_year.columns = ['year', 'count']
        count_by_year.to_csv(out_path, index=False)
    
    def salary_by_area(self, out_path):
        MAX_AREAS = 20 
        data = self.data.copy().dropna(subset=['salary', 'area_name'])
        
        data['salary'] = pd.to_numeric(data['salary'], errors='coerce')
        data = data[(data['salary'] >= CreateStatistics.MIN_SALARY) & 
                    (data['salary'] <= CreateStatistics.MAX_SALARY)]
        
        area_counts = data['area_name'].value_counts(normalize=True)
        valid_areas = area_counts[area_counts >= CreateStatistics.VALID_AREA].index
        data = data[data['area_name'].isin(valid_areas)]
        
        salary_by_city = data.groupby('area_name')['salary'].mean().reset_index()
        salary_by_city.columns = ['area_name', 'average_salary']
        salary_by_city = salary_by_city.sort_values(by='average_salary', ascending=False)
        salary_by_city.head(MAX_AREAS).rename(columns={'average_salary': 'salary'}).to_csv(out_path, index=False)
    
    def count_by_area(self, out_path):
        MAX_AREAS = 15
        data = self.data.copy().dropna(subset=['area_name'])
        area_counts = data['area_name'].value_counts().reset_index()
        area_counts.columns = ['area_name', 'count']
        area_counts = area_counts.sort_values(by='count', ascending=False)
        
        top_areas = area_counts.head(MAX_AREAS)
        other_areas = area_counts.tail(len(area_counts) - MAX_AREAS)
        other_row = pd.DataFrame({'area_name': ['Другой'], 'count': [other_areas['count'].sum()]})
        
        pd.concat([top_areas, other_row], ignore_index=True).sort_values(by='count', ascending=False).to_csv(out_path, index=False)
        
    
    def __call__(self):
        self.salary_by_year(f'{self.out_folder}/salary_by_year.csv')
        self.count_by_year(f'{self.out_folder}/count_by_year.csv')
        self.salary_by_area(f'{self.out_folder}/salary_by_area.csv')
        self.count_by_area(f'{self.out_folder}/count_by_area.csv')