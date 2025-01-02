import pandas as pd
from clear_data import DataCleaner


data = pd.read_csv('data/vacancies_2024.csv', low_memory=False)
cleaner = DataCleaner(data)
cleaner.profession_key_words(['аналитик', 'analytics', 'analyst']).process().to_csv('data/cleaned_data.csv', index=False)