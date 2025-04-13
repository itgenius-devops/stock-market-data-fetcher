#!/bin/bash

# Prompt for the absolute path to the JSON file
read -p "Enter the absolute path to the JSON file: " json_file

# Check if the file exists
if [ ! -f "$json_file" ]; then
  echo "Error: File '$json_file' does not exist."
  exit 1
fi

# Ensure jq is installed
if ! command -v jq &>/dev/null; then
  echo "Installing jq..."
  sudo yum install jq -y || { echo " Failed to install jq."; exit 1; }
fi

# MySQL credentials and config
DB_HOST="3.239.200.150" # Make sure to use your own database public IP 
DB_USER="itgenius_app_user"
DB_PASS="Databaseuserstrongpassword@123"
DB_NAME="itgenius_app_database"
TABLE_NAME="stock_prices"

# Test MySQL connectivity
echo "🔍 Checking database connection..."
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" -e "USE $DB_NAME;" 2>/dev/null
if [ $? -ne 0 ]; then
  echo " Cannot connect to MySQL or database '$DB_NAME' does not exist."
  exit 1
fi

# Create table if it doesn't exist
echo "📦 Creating table '$TABLE_NAME' if it doesn't exist..."
mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" <<EOF
CREATE TABLE IF NOT EXISTS $TABLE_NAME (
    id INT AUTO_INCREMENT PRIMARY KEY,
    timestamp DATETIME NOT NULL,
    open DECIMAL(10,4),
    high DECIMAL(10,4),
    low DECIMAL(10,4),
    close DECIMAL(10,4),
    volume INT
);
EOF

# Parse JSON and insert data
echo " Starting data import into table '$TABLE_NAME'..."

jq -r '."Time Series (5min)" | to_entries[] | "\(.key),\(.value["1. open"] // 0),\(.value["2. high"] // 0),\(.value["3. low"] // 0),\(.value["4. close"] // 0),\(.value["5. volume"] // 0)"' "$json_file" | while IFS=',' read -r ts open high low close volume; do

  if [[ -z "$ts" || -z "$open" || -z "$high" || -z "$low" || -z "$close" || -z "$volume" ]]; then
    echo " Skipping incomplete row: $ts, $open, $high, $low, $close, $volume"
    continue
  fi

  echo "🔄 Inserting: $ts | O:$open H:$high L:$low C:$close V:$volume"

  mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" -e \
  "INSERT INTO $TABLE_NAME (timestamp, open, high, low, close, volume) VALUES ('$ts', $open, $high, $low, $close, $volume);" 2>/dev/null

  if [ $? -ne 0 ]; then
    echo " Failed to insert row: $ts"
  fi
done

echo "✅ Import complete."

