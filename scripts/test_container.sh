#!/bin/bash
started=false
count=1
while [ "$count" != 5 -a "$started" != "true" ]; do 

  echo "${STAGE_NAME} starting container... [Attempt: ${count}]"
  
  status_code=$(curl -LI http://localhost:8081 -o /dev/null -w '%{http_code}\n' -s)

  if [ "$status_code" -eq 500 ]; then 
    started=true
  else
    sleep 1
  fi

  count=$[$count+1]

done

if [ "$started" != "true" ]
then
  exit 1
fi