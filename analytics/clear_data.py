import pandas as pd

class DataCleaner:
    def __init__(self, data: pd.DataFrame):
        self.data = data
    
    def profession_key_words(self, key_words: list[str]) -> 'DataCleaner':
        self.__key_words = key_words
        return self
    
    def process(self) -> pd.DataFrame:
        return self.data[self.data['name'].str.contains('|'.join(self.__key_words), case=False)]