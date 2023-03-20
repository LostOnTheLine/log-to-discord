#!/bin/sh

# Print out some debug information
echo "Checking log files: $LOG_FILE"
echo "Discord webhook: $DISCORD_WEBHOOK"

# Check if log file exists
missing_files=""
for file in $(echo $LOG_FILE | tr ',' ' '); do
    if [ ! -f "$file" ]; then
        missing_files="$missing_files $file"
        echo "Log file $file cannot be found"
    fi
done

if [ -z "$(find $(echo $LOG_FILE | tr ',' ' ') -type f -print -quit)" ]; then
    echo "No log files found"
    exit 1
elif [ -n "$missing_files" ]; then
    echo "Missing log files:$missing_files"
    exit 1
fi

# Check if Discord webhook can be reached
if ! curl -sSf "$DISCORD_WEBHOOK" >/dev/null; then
  echo "Discord Webhook cannot be reached"
  exit 1
fi

# Both checks passed, container is healthy
exit 0
