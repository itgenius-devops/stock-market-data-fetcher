#!/bin/bash

# Dates you want to fetch data for
dates=("2025-04-09" "2025-04-10" "2025-04-11")

# API keys and URLs
base_url="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&apikey=L2CS5Y3MI25MWQRY"

# Loop through the dates and download data
for date in "${dates[@]}"; do
    # Download CSV
    csv_filename="csv/ibm-intraday-${date}.csv"
    curl -o "$csv_filename" "${base_url}&datatype=csv"

    # Download JSON
    json_filename="json/ibm-intraday-${date}.json"
    curl -o "$json_filename" "${base_url}&datatype=json"

    # Log output
    echo "Downloaded data for date: $date" >> "logs/ibm-intraday-${date}.log"
done
