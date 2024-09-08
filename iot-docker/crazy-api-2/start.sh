#!/bin/bash
# Function to generate a random sleep time between 1 and 80 seconds
random_sleep() {
  sleep_time=$((1 + RANDOM % 80))
  echo "Sleeping for $sleep_time seconds..."
  sleep $sleep_time
}

# Initial sleep before starting the loop
random_sleep

# Generate random web traffic
while true; do
  echo "Sending requests..."

  # Example APIs from CoinGecko 
  curl -s https://api.coingecko.com/api/v3/simple/price?ids=ethereum&vs_currencies=usd
  random_sleep
  curl -s https://api.coingecko.com/api/v3/simple/price?ids=dogecoin&vs_currencies=usd
  random_sleep

  # Example APIs from NASA (requires API key)
  curl -s "https://api.nasa.gov/planetary/apod?api_key=4i63ueu6rf7y7Dl08dSRPJ16oXQaFlxnoEtnHaJp"
  random_sleep
  curl -s "https://api.nasa.gov/neo/rest/v1/feed?api_key=4i63ueu6rf7y7Dl08dSRPJ16oXQaFlxnoEtnHaJp"
  random_sleep
  
  # Random beer
  curl -s https://api.punkapi.com/v2/beers/random
  random_sleep

  # Random photo
  curl -s https://picsum.photos/200
  random_sleep

  # Useless facts
  curl -s https://uselessfacts.jsph.pl/random.json?language=en
  random_sleep

  # Random activity
  curl -s https://www.boredapi.com/api/activity
  random_sleep

  # Random advice
  curl -s https://api.adviceslip.com/advice
  random_sleep


  echo "Sleeping for a random time before the next cycle..."
  random_sleep
done