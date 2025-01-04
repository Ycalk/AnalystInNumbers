import asyncio
import pandas as pd
from general_statistics.create import CreateGeneralStatistics
from prepare_data import DataPreparator
from utils.async_currency_converter import AsyncCurrencyConverter
from datetime import datetime
    
async def prepare_data():
    data = pd.read_csv('data/vacancies_2024.csv', low_memory=False)
    preparator = DataPreparator(data)
    await (preparator
           .with_profession_key_words(['аналитик', 'analytics', 'analyst'])
           .with_calculated_salary()
           .with_async_converted_salary(AsyncCurrencyConverter()))
    preparator.data.to_csv('data/prepared_data.csv', index=False)

def create_statistics():
    creator = CreateGeneralStatistics('data/prepared_data.csv', 'general_statistics/out')
    creator.run()

if __name__ == "__main__":
    create_statistics()