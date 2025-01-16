import pandas as pd

CURRENCIES = ["USD", "EUR", "KZT", "UAH", "BYR", "AZN", "UZS", "KGS", "GEL"]

class CurrencyRateParser:
    def __init__(self, date_start: str = "2003-01-01", date_end: str = "2024-12-01"):
        self.__date_range = pd.date_range(start=date_start, end=date_end, freq='MS').strftime('%d/%m/%Y').tolist()
    
    def __call__(self) -> pd.DataFrame:
        all_currency_data = []
        for date in self.__date_range:
            daily_data = self.fetch_currency_data(date)
            if not daily_data.empty:
                all_currency_data.append(daily_data)
        collected = pd.concat(all_currency_data, ignore_index=True)
        pivoted_data = collected.pivot(index='date', columns='CharCode', values='normalized')
        return pivoted_data.reindex(columns=CURRENCIES)
        
    def fetch_currency_data(self, date_str):
        url = f"http://www.cbr.ru/scripts/XML_daily.asp?date_req={date_str}"
        data = pd.read_xml(url, xpath=".//Valute", encoding="windows-1251")

        if data is not None and not data.empty:
            data['date'] = pd.to_datetime(date_str, format='%d/%m/%Y').strftime('%Y-%m')
            data = data[data['CharCode'].isin(CURRENCIES)]
            data['Value'] = pd.to_numeric(data['Value'].str.replace(',', '.'), errors='coerce')
            data['Nominal'] = pd.to_numeric(data['Nominal'], errors='coerce')
            data['normalized'] = (data['Value'] / data['Nominal']).round(9)
            return data[['date', 'CharCode', 'normalized']]

        return pd.DataFrame(columns=['date', 'CharCode', 'normalized'])