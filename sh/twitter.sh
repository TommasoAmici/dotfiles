#!/bin/sh
#
# Author: Tommaso Amici

# Lookup a tweet's text using the Twitter API
tweet() {
  TWEET_ID=$(echo "$1" | rg --regexp="(\d{5,})" -o)
  URL="https://api.twitter.com/2/tweets?ids=$TWEET_ID&tweet.fields=text"
  curl --silent \
    -H "Authorization: Bearer $TWITTER_BEARER_TOKEN" \
    "$URL" | jq ".data[].text"
}
