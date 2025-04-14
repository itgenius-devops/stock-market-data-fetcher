#!/bin/bash

# Author: Naanorle

# Description: A Shell script that downloads stock data in both JSON and CSV format on different dates

# Define dates as an array
Dates=("2025-04-09" "2025-04-10" "2025-04-11")

# Define directories

BASE_DIR="/home/ec2-user/git_assignment/stock-market-data-fetcher/Naanorle"
CSV_DIR="${BASE_DIR}/csv"
JSON_DIR="${BASE_DIR}/json"
LOG_DIR="${BASE_DIR}/logs"  

# Loop through each date and download data
for date in "${Dates[@]}"; do
{
    echo "📅 Processing $date"

# Download stock data in CSV format

    wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=csv&apikey=L2CS5Y3MI25MWQRY" \
         -O "${CSV_DIR}/ibm-intraday-${date}.csv"
    
    echo "✅ Saved CSV for $date"

 # Download stock data in JSON format

    wget "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY" \
         -O "${JSON_DIR}/ibm-intraday-${date}.json"
    echo "✅ Saved JSON for $date"

    echo "✔️ Done processing $date"

} > "${LOG_DIR}/ibm-intraday-${date}.log" 2>&1  
done

echo "🎉 All downloads completed!"




