#!/bin/bash
sleep 30
# Generate random web traffic
while true; do
  echo "Sending requests..."
  curl -s https://jsonplaceholder.typicode.com/posts
  curl -s https://jsonplaceholder.typicode.com/comments
  sleep 5
  curl -s https://api.chucknorris.io/jokes/random
  curl -s https://dog.ceo/api/breeds/image/random
  sleep 5
  curl -X POST -s -d '{"userId": 1, "title": "foo", "body": "bar"}' https://jsonplaceholder.typicode.com/posts
  curl -s https://api.coindesk.com/v1/bpi/currentprice.json
  curl -s https://catfact.ninja/fact
  curl -s https://httpbin.org/get
  curl -s https://httpbin.org/ip
  sleep 5
  curl -s https://ipinfo.io/json
  curl -X POST -s -d '{"title": "foo", "body": "bar"}' https://jsonplaceholder.typicode.com/posts
  curl -s https://api.agify.io?name=bob
  curl -s https://api.genderize.io?name=alice
  curl -s https://api.nationalize.io?name=nancy
  sleep 5
  curl -s https://api.adviceslip.com/advice
  curl -s https://icanhazdadjoke.com/ -H 'Accept: text/plain'
  curl -s https://api.spacexdata.com/v4/launches/latest
  curl -s https://www.boredapi.com/api/activity
  curl -s "https://api.open-meteo.com/v1/forecast?latitude=35.6895&longitude=139.6917&current_weather=true"
  echo "Sleeping for 30 seconds..."
  sleep 30
done
