#get data from quandl.com, btc/USD for the last 365 days
url_bitstamp <- "http://www.quandl.com/api/v1/datasets/BCHARTS/BITSTAMPUSD.csv?rows=365"
url_no_transactions <- "http://www.quandl.com/api/v1/datasets/BCHAIN/NTRAN.csv?rows=366"

csv_bitstamp <- read.csv(url_bitstamp)
csv_no_transactions <- read.csv(url_no_transactions)

csv_bitstamp$Date <- as.Date(as.character(csv_bitstamp$Date))
csv_no_transactions$Date <- as.Date(as.character(csv_no_transactions$Date))

#cat(file=stderr(), str(csv_bitstamp), "\n")
