#!/bin/bash

# ====Configuration===
API_KEY="L2CS5Y3MI25MWQRY"
Symbol="IBM"
Interval="5min"
Start_date=$(date +%F)

URL_CSV="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$Symbol&interval=$Interval&outputsize=full&datatype=csv&apikey=$API_KEY"
URL_json="https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=$Symbol&interval=$Interval&outputsize=full&datatype=json&apikey=$API_KEY"

# Create directories if they don't exist
mkdir -p /home/ec2-user/projects/csv /home/ec2-user/projects/json /home/ec2-user/projects/log
cd /home/ec2-user/projects || exit 1

csv_file="csv/ibm-intraday-$Start_date.csv"
json_file="json/ibm-intraday-$Start_date.json"
log_file="log/ibm-intraday-$Start_date.log"

# Download CSV
echo "Downloading CSV file: $Start_date....." >> "$log_file"
wget -q -O "$csv_file" "$URL_CSV" >> "$log_file" 2>&1

# Download JSON
echo "Downloading JSON file: $Start_date....." >> "$log_file"
wget -q -O "$json_file" "$URL_json" >> "$log_file" 2>&1

echo "[$(date)] Download completed." >> "$log_file"



