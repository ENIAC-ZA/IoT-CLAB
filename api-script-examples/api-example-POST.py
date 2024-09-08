import requests
import json

# Define the URL
url = "http://localhost:8080/flowform"
dpid = 121999831393346 #Use output in GET script for DPID value

# Define the payload
payload = {
    "dpid": dpid, ##########<--ChangeMe
    "operation": "add",
    "table_id": 0,
    "priority": 1,
    "idle_timeout": 0,
    "hard_timeout": 0,
    "cookie": 0,
    "cookie_mask": 0,
    "out_port": 0,
    "out_group": 0,
    "meter_id": 0,
    "metadata": 0,
    "metadata_mask": 0,
    "goto": 0,
    "matchcheckbox": False,
    "clearactions": False,
    "SEND_FLOW_REM": False,
    "CHECK_OVERLAP": False,
    "RESET_COUNTS": False,
    "NO_PKT_COUNTS": False,
    "NO_BYT_COUNTS": False,
    "match": {
        "in_port": 1,
        "eth_dst": "00:00:00:00:00:03"
    },
    "apply": [
        {"OUTPUT": "4"}
    ],
    "write": {}
}

# Send the POST request
response = requests.post(url, json=payload)

# Print the response
print(response.status_code)
print(response.text)
