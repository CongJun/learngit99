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

2.6 Pandas数据整理/*{{{*/
排序函数
	df.sort_values(by='收盘价', ascending=0)
	df.sort_values(by=['交易日期', '收盘价'], ascending=[0,1])

上下合并两个df
	生成两个df
	df1 = df.iloc[0:15][['交易日期', '股票代码', '收盘价', '成交量']]
	df2 = df.iloc[10:25][['交易日期', '股票代码', '收盘价', '成交量']]

	df3 = df1.append(df2)
	df3 = df1.append（df2, ignore_index=True)

去重
	df3.drop_duplicates(
		subset = ['交易日期', '股票代码'],
		keep = 'first',  # first, last, False
		inplace = True
	)

其他
	df.reset_index(inplace=True, drop=True)
	df.rename(columns = {
		'收盘价': 'close',
		'开盘价': 'open',
		'股票代码': 'code',
		'股票名称': 'name',
		'交易日期': 'date'}, inplace = True)
	
	df.empty

	new_df = df.DataFrame()

	df.T

2.6 Pandas数据整理/*}}}*/

2.7 Pandas中的字符串操作/*{{{*/
	print(df['股票代码'])
	print(df[['股票代码', '股票名称']])
	
	print('sh600000'[:2]
	print(df['交易日期'][-2:])
	print(df['交易日期'].str[-2:])
	
	print(df['股票代码'].str.upper())
	print(df['股票代码'].str.lower())
	print(df['股票代码'].str.len())
	df['股票代码'] = df['股票代码'] + ' '
	df['股票代码'] = df['股票代码'].str.strip()
	print(df['股票代码'].str.contains('find_str'))
	
	Print(df[['开盘价', '收盘价']].str.contains('21'))
	AttributeError: 'DataFrame' object has no attribute 'str'
	
	print(df['股票代码'].str.replace('sz', 'sh'))
	
2.7 Pandas中的字符串操作/*}}}*/

2.8 Pandas中的时间处理/*{{{*/
print(type(df))
#-return-# : <class 'pandas.core.frame.DataFrame'>
print(type(df['交易日期']))
#-return-# : <class 'pandas.core.series.Series'>
print(type(df.at[0, '交易日期']))
#-return-# : <class 'str'>

df['交易日期'] = pd_to_datatime(df['交易日期'])
print(type(df['交易日期']))
#-return-# : <class 'pandas._libs.tslibs.timestamps.Timestamp'>

print(pd.to_datetime('2021-01-30'))
#-return-# : 2021-01-30 00:00:00

print(df['交易日期'].dt.year)
print(df['交易日期'].dt.week)
print(df['交易日期'].dt.dayofyear)
print(df['交易日期'].dt.dayofweek)
print(df['交易日期'].dt.weekday)
print(df['交易日期'].dt.weekday_name)
print(df['交易日期'].dt.days_in_month)
print(df['交易日期'].dt.is_month_start)
print(df['交易日期'].dt.is_month_end)

print(df['交易日期'] + pd.Timedelta(day=1))
print((df['交易日期'] + pd.Timedelta(day=1) -df['交易日期'])

2.8 Pandas中的时间处理/*}}}*/

2.9 Pandas的滚动操作/*{{{*/
rolling操作
	df['收盘价_3天均值'] = df['收盘价'].rolling(3).mean()
	print(df['收盘价'].rolling(20).max())
	print(df['收盘价'].rolling(60).min())
	print(df['收盘价'].rolling(3).std())

expanding操作
	df['收盘价_至今均值'] = df['收盘价'].expanding().mean()
	print(df['收盘价'].expanding().max())
	print(df['收盘价'].expanding().min())
	print(df['收盘价'].expanding().std())

输出到本地文件
	df.to_csv('output.csv', encoding='gbk', index=False)
2.9 Pandas的滚动操作/*}}}*/

3.1 Pandas批量导入数据/*{{{*/
import pandas of pd
import os

file_location = r'D:\path\stock_data'

for root, dirs, files in os.walk(file_location):
	print('当前的目录', root)
	print('当前目录下包含的目录', dirs)
	print('当前目录下包含的文件', files)

file_list = []
for root, dirs, files in os.walk(file_location):
	for filename in files:
		if filename.endswith('csv'):
			file_path = os.path.join(root, filename)
			file_path = os.path.abspath(file_path)
			file_list.append(file_path)
all_data = pd.DataFrame()
	for fp in sorted(file_list)[:300]:
		df = pd.read_csv(fp, skiprow=1, encoding='gbk')
		all_data = all_data.apped(df, ignore_index=True)

all_data.to_hdf(
	r'D:\path\a_stock.h5'
	key='all_data')

all_data.read_hdf(
	r'D:\path\a_stock.h5'
	key='all_data')
3.1 Pandas批量导入数据/*}}}*/

3.2 在Pandas中使用HDF/*{{{*/
import pandas as pd
import os

pd.set_option('expand_frame_repr', False)

file_list = []
file_location = r'd:\path\filename.csv'

for root, dirs, files in os.walk(file_location):
	for filename in files:
		if filename.endswith('.csv'):
			file_path = os.path.join(root, filename)
			file_path = os.path.abspath(file_path)
			file_list.append([filename, file_path])

h5_store = pd.HDFStore('a_stock_100.h5', mode='w')

for filename, file_path in sorted(file_list):
	stock_code = filename.split(',')[0]
	df = pd.read_csv(file_path, encoding = 'gbk', skiprow = 1, parse_dates=['交易日期'])

	h5_store[stock_code] = df.iloc[:300]
	h5_store[stock_code] = df

h5_store.close()

h5_store = pd.HDFStore('a_stock_100.h5', mode='r')
print(h5_store.keys())
print(h5_store.get('sh600000'))
print(h5_store['sh600000'])
h5_store.close()




3.2 在Pandas中使用HDF/*}}}*/

3.3 Pandas数据周期转换/*{{{*/
import pandas as pd
pd.set_option('expand_frame_repr', False)

df: pd.DataFrame = pd.read_hdf('a_stock_100.h5', key='sh600000')
print(df.head(20))

df.set_index('交易日期', inplace=True)

rule_type = '1W'
period_df['开盘价'] = df['开盘价'].resample(rule=rule_type).frist()
period_df['收盘价'] = df['收盘价'].resample(rule=rule_type).last()
period_df['最低价'] = df['最低价'].resample(rule=rule_type).min() 
period_df['最高价'] = df['最高价'].resample(rule=rule_type).max()
period_df['成交量'] = df['成交量'].resample(rule=rule_type).sum()

period_df = period_df[['开盘价', '收盘价', '最低价', '最高价', '成交量']]


rule_type = '1W'
period_df = df.resample(rule=rule_type, on='交易日期', base=0, label='left', closed='left').agg(
	{
		'开盘价': 'first',
		'最高价': 'max',
		'最低价': 'min',
		'收盘价': 'last',
		'成交量': 'sum',
	}
)
period_df = period_df[['开盘价', '收盘价', '最低价', '最高价', '成交量']]


period_df.dropna(subset=['开盘价'], inplace=True)
period_df = period_df[period_df['成交量'] > 0]

3.3 Pandas数据周期转换/*}}}*/

3.4 Pandas分组处理操作/*{{{*/
import pandas as pd
pd.set_option('expand_frame_repr', False)

df.groupby('交易日期').size()
df.groupby('股票代码').size()

df.groupby('交易日期').get_group('2019-03-25')
df.groupby('股票代码').get_group('sh600000')

df.groupby('股票代码').describe()
df.groupby('股票代码').get_group('sh600000').describe()
df.groupby('股票代码').head(3)
df.groupby('股票代码').tail(3)
df.groupby('股票代码').first()
df.groupby('股票代码').last()
df.groupby('股票代码').nth(2)
df.groupby('股票代码', as_index=False).nth(2)

3.4 Pandas分组处理操作/*}}}*/


print(type(df['交易日期'].str[-2:]))
<class 'pandas.core.series.Series'>

print(type(df['交易日期'].str))
<class 'pandas.core.strings.StringMethods'>

question/*{{{*/

2021-01-28-01/*{{{*/
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
2021-01-28-01/*}}}*/

2021-01-29-01/*{{{*/
print(df) column和数据无法对齐？
2021-01-29-01/*}}}*/

2021-01-30-01/*{{{*/
print(df['交易日期'].dt.weekday_name) 报错
2021-01-30-01/*}}}*/

ok-2021-02-02-01/*{{{*/
在课程 3.3 Pandas数据周期转换 中有下面的代码：

加这条语句的含义是什么：period_df = period_df[['开盘价', '最高价', '最低价', '收盘价', '成交量']]
不加这条语句执行 print(period_df) 也没问题啊。

对列重新排序

C:\Users\congjun\anaconda3\python.exe D:/CJo/study/quant/xbx_stock_2019/program/pandas高阶/3_转换数据周期resample.py
              收盘价    开盘价    最高价    最低价          成交量
交易日期                                               
1999-11-14  28.05  29.50  29.80  27.00  218496600.0
1999-11-21  26.88  28.20  28.25  26.37   59018300.0

C:\Users\congjun\anaconda3\python.exe D:/CJo/study/quant/xbx_stock_2019/program/pandas高阶/3_转换数据周期resample.py
              开盘价    最高价    最低价    收盘价          成交量
交易日期                                               
1999-11-14  29.50  29.80  27.00  28.05  218496600.0
1999-11-21  28.20  28.25  26.37  26.88   59018300.0


ok-2021-02-02-01/*}}}*/

2021-02-02-02：DataFrame格式的简介/*{{{*/

2021-02-02-02：DataFrame格式的简介/*}}}*/

2021-02-02-03：股票得收盘价非常重要，为什么？/*{{{*/
没有收盘价就无法计算股票得涨跌幅。
2021-02-02-03：股票得收盘价非常重要，为什么？/*}}}*/

ok 2021-02-02-04：pandas的apply函数和labmda的用法/*{{{*/
https://www.jianshu.com/p/4fdd6eee1b06
DataFrame.apply函数会遍历每一个元素，对元素运行指定的function。

lambda表达式是一种匿名函数，对应python中自定义函数def，是定义某个函数时比较高级的写法
ok 2021-02-02-04：pandas的apply函数和labmda用法/*}}}*/

question/*}}}*/


标准差
https://baike.baidu.com/item/%E6%A0%87%E5%87%86%E5%B7%AE
中位数
https://baike.baidu.com/item/%E4%B8%AD%E4%BD%8D%E6%95%B0








var hq_str_sh601012="隆基股份
29.610 今开    108.300
25.300 昨收    106.920
29.720 成交    109.010    
30.360 最高    111.540
28.200 最低    105.080
29.710 买一    109.010
29.720 卖一    109.020
24844236 成交量（股）    71491418
740092993.250  成交额    7762243270.000
100  盘后成交量？    31434   **
29.710                   109.010  成交
14200  买二数量    324600
29.650 买二    109.000
5400   买三数量    6222
29.630 买三    108.990
1600   买四数量    4000
29.620 买四    108.980
1200   买五数量    1100
29.610 买五     108.970
50500  卖一数量    44200
29.720 卖一    109.020
5000   卖二数量    700
29.730 卖二    109.030
6400   卖三数量    3900
29.740 卖三    109.040
6500   卖四数量    11500
29.750 卖四    109.050
7000   卖五数量    6596
29.760 卖五    109.060
2021-02-02  日期    2021-02-02
15:35:00    时间    15:00:00
    00
";



# ===考察股票历史数据质量
1. 是否又开、高、收、低价格、成交量、成交额。和行情软件抽样比对，保证准确性。
2.数据开始时间，尽可能早。
3.是否包含退市股票（幸存者偏差）。
4.是否可以计算出复权价格、是否有原始得开、高、收、低价格
