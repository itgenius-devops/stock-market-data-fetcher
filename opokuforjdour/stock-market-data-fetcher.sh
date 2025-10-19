#!/bin/bash

# Define variables for the URL base and API key
API_KEY="L2CS5Y3MI25MWQRY"
SYMBOL="IBM"
BASE_URL="https://www.alphavantage.co/query"

# Define the dates you need
DATES=("2025-04-09" "2025-04-10" "2025-04-11")

# Loop through each date to download data
for DATE in "${DATES[@]}"
do
    # Format the filenames
    CSV_FILE="csv/ibm-intraday-${DATE}.csv"
    JSON_FILE="json/ibm-intraday-${DATE}.json"
    LOG_FILE="logs/ibm-intraday-${DATE}.log"

    # Fetch the CSV data
    echo "Fetching CSV data for ${DATE}..." >> ${LOG_FILE}
    curl -s "${BASE_URL}?function=TIME_SERIES_INTRADAY&symbol=${SYMBOL}&interval=5min&outputsize=full&datatype=csv&apikey=${API_KEY}" -o ${CSV_FILE} >> ${LOG_FILE} 2>&1

    # Fetch the JSON data
    echo "Fetching JSON data for ${DATE}..." >> ${LOG_FILE}
    curl -s "${BASE_URL}?function=TIME_SERIES_INTRADAY&symbol=${SYMBOL}&interval=5min&outputsize=full&datatype=json&apikey=${API_KEY}" -o ${JSON_FILE} >> ${LOG_FILE} 2>&1

    # Log completion
    echo "Data for ${DATE} fetched successfully." >> ${LOG_FILE}
done

