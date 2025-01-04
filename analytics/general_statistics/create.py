import pandas as pd

class CreateGeneralStatistics:
    min_salary = 1000
    max_salary = 1000000
    
    
    def __init__(self, prepared_data_path, out_folder):
        self.data = pd.read_csv(prepared_data_path)
        self.out_folder = out_folder
        
    def salary_by_year(self, out_path):
        data = self.data.copy().dropna(subset=['salary', 'published_at'])
        
        data['salary'] = pd.to_numeric(data['salary'], errors='coerce')
        data['published_at'] = pd.to_datetime(data['published_at'], errors='coerce', utc=True)
        
        data = data.dropna(subset=['salary', 'published_at'])
        data['year'] = data['published_at'].dt.year
        
        data = data[(data['salary'] >= CreateGeneralStatistics.min_salary) & 
                    (data['salary'] <= CreateGeneralStatistics.max_salary)]
        
        salary_trend = data.groupby('year')['salary'].mean().reset_index()
        salary_trend.columns = ['year', 'average_salary']
        salary_trend.to_csv(out_path, index=False)
    
    def run(self):
        self.salary_by_year(f'{self.out_folder}/salary_by_year.csv')