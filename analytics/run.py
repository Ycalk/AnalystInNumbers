import asyncio
import pandas as pd
from prepare_data import DataPreparator
from stats.create import CreateStatistics
from utils.async_currency_converter import AsyncCurrencyConverter
from datetime import datetime

from utils.currencies_rates_parser import CurrencyRateParser
from utils.currency_converter import CurrencyConverter

def create_statistics():
    data = pd.read_csv('data/vacancies_2024.csv', low_memory=False)
    preparator = DataPreparator(data)
    parser = CurrencyRateParser()
    (preparator
        .with_calculated_salary()
        .with_converted_salary(CurrencyConverter(parser())))
    
    creator = CreateStatistics(preparator.data.copy(), 'stats/out/all')
    creator()

    preparator.with_profession_key_words(['аналитик', 'analytics', 'analyst'])
    creator = CreateStatistics(preparator.data.copy(), 'stats/out/profession')
    creator()

if __name__ == "__main__":
    create_statistics()