#!/bin/bash

GITLAB_URL="https://gitlab.example.com"

if [$# != 2] ; then
  echo "USAGE: $0 PROJECT_ID PRIVATE_TOKEN"
  exit 1
fi

GITLAB_PROJECT_ID=$1
GITLAB_TOKEN=$2

PIPELINE_ENDPOINT="/api/v4/projects/$GITLAB_PROJECT_ID/pipelines"
GITLAB_PIPELINE_URL=$GITLAB_URL$PIPELINE_ENDPOINT

PIPELINES=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" $GITLAB_PIPELINE_URL)
PIPELINE_ID=$(echo $PIPELINES | jq .[].id | head -n 1)

PIPELINE_STATUS=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" $GITLAB_PIPELINE_URL/$PIPELINE_ID | jq .status)
PIPELINE_FINISHED=false

until $PIPELINE_FINISHED; do
        PIPELINE_STATUS=$(curl --header "PRIVATE-TOKEN: $GITLAB_TOKEN" $GITLAB_PIPELINE_URL/$PIPELINE_ID | jq .status
)
        if [ "$PIPELINE_STATUS" == "\"success\"" ] ; then
                PIPELINE_FINISHED=true
                echo "Pipeline $PIPELINE_ID finished : $PIPELINE_STATUS"
                exit 0
        elif [ "$PIPELINE_STATUS" == "\"failed\"" ] ; then 
                PIPELINE_FINISHED=true
                echo "Pipeline $PIPELINE_ID finished : $PIPELINE_STATUS"
                exit 1
        else
                echo "Waiting for pipeline $PIPELINE_ID installation"
                sleep 10
        fi
done