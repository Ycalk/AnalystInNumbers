from datetime import datetime
import pandas as pd
import asyncio

class DataPreparator:
    def __init__(self, data: pd.DataFrame):
        self.data = data
    
    def with_profession_key_words(self, key_words: list[str]) -> 'DataPreparator':
        self.data = self.data[self.data['name'].str.contains('|'.join(key_words), case=False)]
        return self
    
    def with_calculated_salary(self) -> 'DataPreparator':
        self.data['salary'] = self.data[['salary_from', 'salary_to']].mean(axis=1)
        self.data = self.data.drop(columns=['salary_from', 'salary_to'])
        return self
    
    def with_converted_salary(self, converter: 'IConverter') -> 'DataPreparator':
        self.data['salary'] = self.data.apply(lambda row: 
            converter.convert_to_rubles(row['salary_currency'], row['salary'], 
                                        pd.to_datetime(row['published_at'], errors='coerce', utc=True)), axis=1)
        self.data = self.data.drop(columns=['salary_currency'])
        return self
    
    async def apply_async(self, df, index, row, converter: 'AsyncIConverter'):
        converted = await converter.convert_to_rubles(row['salary_currency'], row['salary'], pd.to_datetime(row['published_at']))
        df.at[index, 'salary'] = converted
    
    
    async def with_async_converted_salary(self, converter: 'AsyncIConverter') -> 'DataPreparator':
        """
        Do not use
        """
        tasks = []
        for index, row in self.data.iterrows():
            tasks.append(self.apply_async(self.data, index, row, converter))
        print('Tasks created')
        block_size = 50
        tasks_blocks = [tasks[i:i + block_size] for i in range(0, len(tasks), block_size)]
        for index, task_block in enumerate(tasks_blocks):
            await asyncio.gather(*task_block)
            print(f"{index}/{len(tasks_blocks)}")
            await asyncio.sleep(0.2)
        return self
        

class IConverter:
    def convert_to_rubles(self, currency: str, amount: int, date: datetime) -> float:
        raise NotImplementedError()

class AsyncIConverter:
    async def convert_to_rubles(self, currency: str, amount: int, date: datetime) -> float:
        raise NotImplementedError()