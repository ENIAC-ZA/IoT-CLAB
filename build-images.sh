#!/bin/bash

cd iot-docker/

cd crazy-api/
docker build -t crazy-api .
cd ..

cd crazy-api-2/
docker build -t crazy-api-2 .
cd ..

cd radio/
docker build -t radio .
cd ..

cd streamer-nasa/
docker build -t streamer-nasa .
cd ..

cd streamer-nat/
docker build -t streamer-nat .
cd ..

cd weather-api/
docker build -t weather-api .
cd ..

cd ..
