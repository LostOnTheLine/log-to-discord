#!/bin/bash
IFS=',' read -ra files <<< "$LOG_FILE"
tail -n0 -f ${files[@]} | while read line; do
  if [[ ! -z "${FILTER_BY_WORD}" ]] && ! echo "${line}" | grep -iq "${FILTER_BY_WORD}"; then
    continue
  fi
    echo "$line" && \
    curl --silent --fail -X POST -H 'Content-Type: application/json' -d "{\"content\":\"$line\"}" ${DISCORD_WEBHOOK}
done
