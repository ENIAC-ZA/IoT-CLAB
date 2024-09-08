# Define the URL
$url = "http://localhost:8080/data?list=switches"

# Send the GET request
$response = Invoke-RestMethod -Uri $url -Method Get

# Output the response
$response

#Use output in POST script DPID

#GET http://localhost:8080/data?list=switches