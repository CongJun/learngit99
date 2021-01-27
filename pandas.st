import pandas as pd

pd.set_option('expand_frame_repr', Flase)
pd.set_option('display.max_rows', 1000)
pd.set_option('precision', 2)

df = pd.read_csv(
	filepath_or_buffer = r'd:\path\file.csv',
	encoding = 'gbk',
	skiprows = 1,
	nrows = 15,
	parse_dates = ['交易日期'],
	index_col = ['交易日期'],
)

df.shape
	df.shape[0]
	df.shape[1]
	df.shape[-1]

df.columns
	for col in df.columns:
		print(col)

df.index
	for idx in df.index:
		print(idx)

df.dtypes
df.dtypes['开盘价']

df.head(3)
df.tail(4)
df.sample(n=8)
df.sample(frac=0.3)

df.describe()

df1 = df['开盘价']
print(df1)
print(type(df1))
<class 'pandas.core.series.Series'>

df2 = df[['开盘价', '收盘价']]
print(df2)
print(type(df2))
<class 'pandas.core.frame.DataFrame'>

	# parse_dates = ['交易日期']
	index.col = ['交易日期']
df
df.loc[:]
df.loc['1999-11-15']
df.loc[['1999-11-15','2019-04-01']]
df.loc[:, '交易日期', '开盘价':'收盘价']



标准差
https://baike.baidu.com/item/%E6%A0%87%E5%87%86%E5%B7%AE
中位数
https://baike.baidu.com/item/%E4%B8%AD%E4%BD%8D%E6%95%B0
