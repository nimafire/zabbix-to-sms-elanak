#!/bin/bash

TO="$1"
SUBJECT="$2"
MESSAGE="$3"

ENCODED_MESSAGE=$(echo "$MESSAGE" | jq -sRr @uri)

URL="http://payammatni.com/webservice/url/send.php?method=sendsms&format=json&from=FROM&to=PHONE&text=$ENCODED_MESSAGE&type=0&username=USERNAME&password=PASSWORD"

curl -s "$URL"
