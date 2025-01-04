import asyncio
import pandas as pd
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

if __name__ == "__main__":
    asyncio.run(prepare_data())