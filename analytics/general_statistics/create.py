import pandas as pd

class CreateGeneralStatistics:
    min_salary = 1000
    max_salary = 1000000
    
    
    def __init__(self, prepared_data_path, out_folder):
        self.data = pd.read_csv(prepared_data_path)
        self.out_folder = out_folder
    
    def create_year_column(data: pd.DataFrame) -> pd.DataFrame:
        data['published_at'] = pd.to_datetime(data['published_at'], errors='coerce', utc=True)
        data = data.dropna(subset=['salary', 'published_at'])
        data['year'] = data['published_at'].dt.year
        return data
    
    def salary_by_year(self, out_path):
        data = self.data.copy().dropna(subset=['salary', 'published_at'])
        
        data['salary'] = pd.to_numeric(data['salary'], errors='coerce')
        data = CreateGeneralStatistics.create_year_column(data)
        
        data = data[(data['salary'] >= CreateGeneralStatistics.min_salary) & 
                    (data['salary'] <= CreateGeneralStatistics.max_salary)]
        
        salary_trend = data.groupby('year')['salary'].mean().reset_index()
        salary_trend.columns = ['year', 'average_salary']
        salary_trend.to_csv(out_path, index=False)
    
    def count_by_year(self, out_path):
        data = self.data.copy().dropna(subset=['published_at'])
        data = CreateGeneralStatistics.create_year_column(data)
        
        count_by_year = data.groupby('year')['salary'].count().reset_index()
        count_by_year.columns = ['year', 'count']
        count_by_year.to_csv(out_path, index=False)
    
    def salary_by_city(self, out_path):
        data = self.data.copy().dropna(subset=['salary', 'area_name'])
        
        data['salary'] = pd.to_numeric(data['salary'], errors='coerce')
        data = data[(data['salary'] >= CreateGeneralStatistics.min_salary) & 
                    (data['salary'] <= CreateGeneralStatistics.max_salary)]
        
        salary_by_city = data.groupby('area_name')['salary'].mean().reset_index()
        salary_by_city.columns = ['area_name', 'average_salary']
        salary_by_city.to_csv(out_path, index=False)
    
    def run(self):
        self.salary_by_year(f'{self.out_folder}/salary_by_year.csv')
        self.count_by_year(f'{self.out_folder}/count_by_year.csv')
        self.salary_by_city(f'{self.out_folder}/salary_by_city.csv')