#!/bin/bash

# === Configuration ===
API_KEY="L2CS5Y3MI25MWQRY"
SYMBOL="IBM"
INTERVAL="5min"
MYUSERNAME="itgenius-devops"
BASE_URL="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$SYMBOL&interval=$INTERVAL&outputsize=full"
TODAY=$(date +%F)

# === File Paths ===
CSV_FILE="csv/ibm-intraday-$TODAY.csv"
JSON_FILE="json/ibm-intraday-$TODAY.json"
LOG_FILE="logs/ibm-intraday-$TODAY.log"

# Navigate into the working directory
cd /root/stock-market-data-fetcher/$MYUSERNAME
 
# === Create folders if they don't exist ===
mkdir -p csv json logs

# === Download CSV ===
echo "[$(date)] Downloading CSV data..." >> "$LOG_FILE"
wget -q -O "$CSV_FILE" "$BASE_URL&datatype=csv&apikey=$API_KEY" >> "$LOG_FILE" 2>&1

# === Download JSON ===
echo "[$(date)] Downloading JSON data..." >> "$LOG_FILE"
wget -q -O "$JSON_FILE" "$BASE_URL&datatype=json&apikey=$API_KEY" >> "$LOG_FILE" 2>&1

echo "[$(date)] Download complete." >> "$LOG_FILE"

