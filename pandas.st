2.2用pandas查看数据/*{{{*/
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

df.loc.at['2000-03-30', '开盘价']

df.loc
<pandas.core.indexing._iLocIndexer object at 0x00000170AAC13270>

df.iloc
<pandas.core.indexing._iLocIndexer object at 0x00000170AAC13270>
df.iloc[0]
df.iloc[1:3]
df.iloc[:, 1:3]
df.iloc[1:3, 1:3]
df.iloc[:, :]

df.iat[1, 3]

2.2用pandas查看数据/*}}}*/

2.3Pandas中得列操作/*{{{*/
行列加减乘除
	df['交易日期'] + ' 15:00:00'
	df['收盘价'] * 100
	df['收盘价'] * df['成交量']

新增一列
	df['交易所'] = '上交所'

	index = df[df['交易日期'].isin(['2019-03-01'])].index
	df.loc[index, '月头'] = df['交易日期']

删除一列
	del df['交易所']
	df.drop(['收盘价', '交易所'], axis=1, inplace = True)

统计函数
	df['收盘价'].mean()
	df[['开盘价', '收盘价', '成交量']].mean()
	df[['开盘价', '收盘价', '成交量']].mean(axis=0/1)

	df['收盘价'].max()
	df['收盘价'].min()
	df['收盘价'].std()
	df['收盘价'].count()
	df['收盘价'].median()
	df['收盘价'].quantile(0.25)

shift函数
	df['下周期收盘价'] = df['收盘价'].shift(-1)

diff函数
	df['涨跌'] = df['收盘价'].diff(1)
	df['涨跌幅'] = df['收盘价'].pct_change(1)

cum(cumulative)类函数
	df['累计成交量'] = df['成交量'].cumsum()
	(df['涨跌幅'] + 1.0).cumprod()

其他列函数
	df['收盘价_排名'] = df['收盘价'].rank(ascending = True, pct=False)
	df['收盘价'].value_counts()

2.3Pandas中得列操作/*}}}*/

2.4 用Pandas筛选数据/*{{{*/
	df['股票代码'] == 'sh600000'
	df[df['股票代码'] == 'sh600000']
	df[df['股票代码'] == 'sh600000'].index
	df[df['股票代码'].isin(['sh600000', 'sz000001'])]
	df[df['收盘价'] < 10.0]
	df[(df['收盘价'] < 20.0) & (df['成交量'] > 100000)]

2.4 用Pandas筛选数据/*}}}*/

2.5 Pandas空缺值处理/*{{{*/
index = df[df['交易日期'].isin(['2019-03-01', '2019-03-15'])].index
print(type(index)
<class 'pandas.core.indexes.numeric.Int64Index'>
df.loc[index, '月头'] = df['交易日期']

删除空值
	df.dropna(how='any')
	df.dropna(how='all')
	
	df.dropna(subset = ['月头'，'收盘价'], how = 'any')
	df.dropna(subset = ['月头'，'收盘价'], how = 'all')

补全空值
	df.fillna(value='N')
	df['月头'].fillna(value=df['收盘价'], inplace=True)
	df.fillna(method='ffill')
	df.fillna(method='bfill')

找出空值
	df.notnull()
	df.isnull()
	df['月头'].isnull()
	df[df['月头'].isnull]

2.5 Pandas空缺值处理/*}}}*/


question/*{{{*/
2021-01-28-01
老师，这条语句只是把2019年3月1日的index保存了，如何找到所有每月1日的index？
index = df[df['交易日期'].isin(['2019-03-01'])].index

丁
@阿凡达夫斯基 你可以把'2019-03-01'的日期提取到新的一列，只要是01就满足你的要求
通配符写法：df[df['交易日期'].str.endswith('01')].index
那就把月和日都提取到新的列，再group月份，求日的最小值
index = df[df['交易日期'].str.endswith('01')].index
for idx in index:
	print(df.iloc[[idx]]

助教-马科维兹
@阿凡达夫斯基 用if语句试试，先找出相应的行，再找到对应的index
line = df.shape[0]
for idx in range(line):
	print(df[[idx, '交易日期']])

question/*}}}*/


标准差
https://baike.baidu.com/item/%E6%A0%87%E5%87%86%E5%B7%AE
中位数
https://baike.baidu.com/item/%E4%B8%AD%E4%BD%8D%E6%95%B0
