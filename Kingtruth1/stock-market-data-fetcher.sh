#!/bin/bash

# Create required directories if not already created
mkdir -p csv json logs

# Dates to process
DATES=("2025-04-09" "2025-04-10" "2025-04-11")

# Base URLs
CSV_URL="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=csv&apikey=L2CS5Y3MI25MWQRY"
JSON_URL="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=L2CS5Y3MI25MWQRY"


for DATE in "${DATES[@]}"
do
    LOG_FILE="logs/ibm-intraday-${DATE}.log"

    CSV_FILE="csv/ibm-intraday-${DATE}.csv"
    JSON_FILE="json/ibm-intraday-${DATE}.json"

    echo "Download started at $(date)" >> "$LOG_FILE"
    echo "Processing date: $DATE" >> "$LOG_FILE"

    # Download CSV
    curl -s "$CSV_URL" -o "$CSV_FILE"
    if [ $? -eq 0 ]; then
        echo "CSV saved: $CSV_FILE" >> "$LOG_FILE"
    else
        echo "Failed to download CSV for $DATE" >> "$LOG_FILE"
    fi

    # Download JSON
    curl -s "$JSON_URL" -o "$JSON_FILE"
    if [ $? -eq 0 ]; then
        echo "JSON saved: $JSON_FILE" >> "$LOG_FILE"
    else
        echo "Failed to download JSON for $DATE" >> "$LOG_FILE"
    fi

    echo "Download completed at $(date)" >> "$LOG_FILE"
    echo "--------------------------------------" >> "$LOG_FILE"
done

