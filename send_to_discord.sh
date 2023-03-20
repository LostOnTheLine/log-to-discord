#!/bin/bash
tail -f "$LOG_FILE" | while read line; do
    if [[ -n "${FILTER_BY_WORD}" ]] && ! echo "${line}" | grep -iq "${FILTER_BY_WORD}"; then
        continue
    fi
    echo "$line" && \
    curl --silent --fail -X POST -H 'Content-Type: application/json' -d "{\"content\":\"$line\"}" ${DISCORD_WEBHOOK}
done
