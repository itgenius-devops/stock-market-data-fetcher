#!/bin/bash

# Author: Naanorle

# Description: A Shell script that downloads stock data in both JSON and CSV format on different dates

# Defining Dates as a variable

Dates=("2025-04-09" "2025-04-10" "2025-04-11")

#This fore loop will run sequentially to download the files for the  different dates

for Date in "${Dates[@]}"; do
{
   echo "Processing $Date"

# Downloads stock data in csv

wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY" -O /home/ec2-user/git_assignment/stock-market-data-
fetcher/Naanorle/csv/ibm-intraday-$Date.csv"


# Downloads stock data in json

wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY" -O /home/ec2-user/git_assignment/stock-market-data-fetcher/Naanorle/json/ibm-intraday-$Date.json"

} > /home/ec2-user/git_assignment/stock-market-data-fetcher/Naanorle/logs/ibm-intraday-$Date.log 2>&1
done

echo "All downloads completed"


