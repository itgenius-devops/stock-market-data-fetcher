#!/bin/bash


# Author: kinglivil
# Description: Download IBM stock intraday data in JSON and CSV format for 3 specific dates.

# List of dates
DATES=("2025-04-09" "2025-04-10" "2025-04-11")

# Base URLs
API_KEY="L2CS5Y3MI25MWQRY"
BASE_URL_JSON="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=json&apikey=${API_KEY}"
BASE_URL_CSV="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=IBM&interval=5min&outputsize=full&datatype=csv&apikey=${API_KEY}"

# Folder structure
CSV_FOLDER="./csv"
JSON_FOLDER="./json"
LOG_FOLDER="./logs"

# Ensure folders exist
mkdir -p "$CSV_FOLDER" "$JSON_FOLDER" "$LOG_FOLDER"

# Loop through dates and download JSON and CSV
for DATE in "${DATES[@]}"; do
    CSV_FILE="${CSV_FOLDER}/ibm-intraday-${DATE}.csv"
    JSON_FILE="${JSON_FOLDER}/ibm-intraday-${DATE}.json"
    LOG_FILE="${LOG_FOLDER}/ibm-intraday-${DATE}.log"

    {
        echo "Fetching IBM stock data for ${DATE}..."

        # Fetch CSV data
        curl -s "$BASE_URL_CSV" -o "$CSV_FILE"
        echo "Saved CSV to $CSV_FILE"

        # Fetch JSON data
        curl -s "$BASE_URL_JSON" -o "$JSON_FILE"
        echo "Saved JSON to $JSON_FILE"

        echo "✅ Fetch complete for ${DATE}"
    } > "$LOG_FILE" 2>&1
done

