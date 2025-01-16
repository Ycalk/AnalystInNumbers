from datetime import datetime
from prepare_data import IConverter
import pandas as pd

class CurrencyConverter (IConverter):
    def __init__ (self, rates_data : pd.DataFrame):
        self.__rates_data = rates_data
        
    def convert_to_rubles(self, currency: str, amount: int, date: datetime) -> float:
        if currency == "RUR":
            return amount
        
        date_str = date.strftime('%Y-%m')

        try:
            rate = self.__rates_data.loc[self.__rates_data["date"] == date_str][currency].values[0]
            return amount * float(rate)
        except Exception as _:
            return amount