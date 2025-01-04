from datetime import datetime
import requests
import xml.etree.ElementTree as ET
import aiohttp
from prepare_data import IConverter

class AsyncCurrencyConverter:
    def __init__(self):
        self.rates: dict[str, list[_Rate]] = {}

    
    async def convert_to_rubles(self, currency: str, amount: int, date: datetime) -> float:
        if currency == None or amount == None or date == None:
            return None
        
        date = datetime(date.year, date.month, 1)
        
        rate = await self.get_currency_rate(currency, date)
        if rate is None:
            return None
        return amount * rate
    
    async def get_currency_rate(self, currency, date):
        if currency == 'RUR':
            return 1.0
        
        rate = self.get_saved_rate(currency, date)
        if rate is not None:
            return rate
        
        return await self.create_request(currency, date)

    def get_saved_rate(self, currency: str, date: datetime) -> float:
        if currency not in self.rates:
            return None
        
        rates = self.rates[currency]
        for rate in rates:
            if rate.date == date:
                return rate.rate
        
        return None
    
    async def create_request(self, currency: str, date: datetime):
        url = f'https://www.cbr.ru/scripts/XML_daily.asp?date_req=01/{date.month:02}/{date.year}'
        async with aiohttp.ClientSession() as session:
            async with session.get(url) as response:
                response_text = await response.text()
        root = ET.fromstring(response_text)
        
        currencies = self.rates.keys()
        
        for valute in root.findall('Valute'):
            code = valute.find('CharCode').text
            if code in currencies or code == currency:
                rate = float(valute.find('Value').text.replace(',', '.'))
                if code not in self.rates:
                    self.rates[code] = []
                self.rates[code].append(_Rate(rate, date))
        
        return self.get_saved_rate(currency, date)


class _Rate:
    def __init__(self, rate: float, date: datetime):
        self.rate = rate
        self.date = date