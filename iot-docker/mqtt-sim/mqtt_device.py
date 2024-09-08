import time
import paho.mqtt.client as mqtt
import random

broker = "192.168.1.160"
port = 1883
topic = "iot/sensor/data"

client = mqtt.Client()
client.connect(broker, port)

while True:
    temperature = random.uniform(20.0, 30.0)
    humidity = random.uniform(30.0, 50.0)
    
    # Printing values
    print(f"Temperature: {temperature} °C, Humidity: {humidity} %")
    
    # JSON payload with double quotes
    payload = f'{{"temperature": {temperature}, "humidity": {humidity}}}'
    client.publish(topic, payload)
    
    print('Data sent to MQTT broker')
    
    sleep_time = random.uniform(10, 20)  # Random float between 10 and 20 seconds
    print(f"Sleeping for {sleep_time} seconds")
    
    time.sleep(sleep_time)
