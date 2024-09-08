import requests

# Define the URL
url = "http://localhost:8080/data?list=switches"

# Send the GET request
response = requests.get(url)

# Print the response content
print(response.text)