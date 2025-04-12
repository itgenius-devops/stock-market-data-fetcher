#!/bin/bash

# Author: Naanorle

# Description: A Shell script that downloads stock data in both JSON and CSV format on different days 

# Defining the variable Date: Different days for the downloads respectively

Dates=("2025-04-09" "2025-04-10" "2025-04-11")

# Processing the different dates for the download. This fore loop will run sequentially to download the files for the  different dates

for Date in "${Dates[@]}"; do

    echo "Processing $Date"

# Download stock data in Csv format for each date

wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY" -O /home/ec2-user/git_assignment/stock-market-data-fetcher/Naanorle/csv/ibm-intraday-$Date.csv


# Download stock data in Json format for each date

wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY" -O /home/ec2-user/git_assignment/stock-market-data-fetcher/Naanorle/json/ibm-intraday-$Date.json


done

echo "Both downloads completed, thank you. Byee!"
