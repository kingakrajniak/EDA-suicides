import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

df = pd.read_csv("master.csv")
print(df.columns)

pd.set_option('display.max_columns', 12)
print(df.head(5))  # displaying top 10 rows
print(df.dtypes)

df = df.drop([' gdp_for_year ($) ', 'gdp_per_capita ($)'], axis=1)
df = df.rename(columns={'country': 'Country',
                        'year': 'Year',
                        'sex': 'Sex',
                        'age': 'Age',
                        'suicides_no': 'Suicides no',
                        'population': 'Population',
                        'suicides/100k pop': 'Suicides per 100k pop',
                        'country-year': 'Country and year',
                        'generation': 'Generation'})
print(df.columns)

print(df.shape)
df_duplicate_rows = df[df.duplicated()]
print(df_duplicate_rows)  # no duplicate rows

print(df.count())  # a lot of missing hdi data


