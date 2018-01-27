
-- load the data storage directory
data = LOAD '/user/cloudera/rawdata/handson_train/nasdaq_daily_prices' USING PigStorage(',') AS (exchange:chararray,stock_symbol:chararray,date:chararray,stock_price_open:float,stock_price_high:float,stock_price_low:float,stock_price_close:float,stock_volume:int,stock_price_adj_close:float);

-- incase the data from sqoop still contains the header, it is important to filter it out
filtered_data = FILTER data BY exchange != 'exchange';

-- project only the stock_symbol and the volumn
proj_data = FOREACH filtered_data GENERATE stock_symbol, stock_volume;

--group the available records by the symbol
grp_data = GROUP proj_data BY stock_symbol;

--reduce the grouped data by summing the groups
agg_data = FOREACH grp_data GENERATE group AS symbol, SUM(proj_data.stock_volume) AS total_vol;

-- store records in the ouput location
STORE agg_data INTO '/user/cloudera/output/handson_train/pig/total_stock_volume';

-- describe 
-- explain 
-- illustrate
