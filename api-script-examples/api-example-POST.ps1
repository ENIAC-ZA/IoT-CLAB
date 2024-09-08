#Use output in GET script for DPID value

$payload = @{
    dpid = 125360361340736 ##########<--ChangeMe
    operation = "add"
    table_id = 0
    priority = 1
    idle_timeout = 0
    hard_timeout = 0
    cookie = 0
    cookie_mask = 0
    out_port = 0
    out_group = 0
    meter_id = 0
    metadata = 0
    metadata_mask = 0
    goto = 0
    matchcheckbox = $false
    clearactions = $false
    SEND_FLOW_REM = $false
    CHECK_OVERLAP = $false
    RESET_COUNTS = $false
    NO_PKT_COUNTS = $false
    NO_BYT_COUNTS = $false
    match = @{
        in_port = 1
        eth_dst = "00:00:00:00:00:03"
    }
    apply = @(@{OUTPUT = "4"})
    write = @{}
}

$payloadJson = $payload | ConvertTo-Json

Invoke-RestMethod -Uri "http://localhost:8080/flowform" -Method Post -Body $payloadJson -ContentType "application/json"
