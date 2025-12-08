# scan network for suspect outgoing connections
#!/bin/bash
source ~/development_scripts/.env

function scan_network() {
    echo "${GREEN}--- scanning network for suspect outgoing connections${NC}"
    echo "${BLUE}--- this may take a while...${NC}"
    
    # Use netstat to find established connections
    netstat -tuln | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq > /tmp/established_connections.txt
    
    # Check if the file is empty
    if [ ! -s /tmp/established_connections.txt ]; then
        echo "${RED}--- no established connections found.${NC}"
        return
    fi
    
    echo "${GREEN}--- established connections:${NC}"
    cat /tmp/established_connections.txt
    
    # Optionally, you can add more checks or actions here
}

function tail_outgoing_connections() {
    echo "${GREEN}--- tailing outgoing connections${NC}"
    echo "${BLUE}--- this will show real-time outgoing connections${NC}"
    
    # Use netstat to monitor outgoing connections
    netstat -tuln | grep ESTABLISHED | awk '{print $5}' | cut -d: -f1 | sort | uniq | while read -r line; do
        echo "$line"
        sleep 1
    done
}

function scan_network_for_connected_processes() {
    echo "${GREEN}--- scanning network for connected processes${NC}"
    
    # Use lsof to find processes with network connections
    lsof -i -n | grep ESTABLISHED | awk '{print $1, $2, $9}' | sort | uniq > /tmp/connected_processes.txt
    
    # Check if the file is empty
    if [ ! -s /tmp/connected_processes.txt ]; then
        echo "${RED}--- no connected processes found.${NC}"
        return
    fi
    
    echo "${GREEN}--- connected processes:${NC}"
    cat /tmp/connected_processes.txt
}

function log_data_sent_via_network_to_connected_processes() {
    echo "${GREEN}--- logging data sent via network to connected processes${NC}"
    
    # Use lsof to find processes with network connections and log data sent
    lsof -i -n | grep ESTABLISHED | awk '{print $1, $2, $9}' | sort | uniq > /tmp/data_sent_to_connected_processes.txt
    
    # Check if the file is empty
    if [ ! -s /tmp/data_sent_to_connected_processes.txt ]; then
        echo "${RED}--- no data sent to connected processes found.${NC}"
        return
    fi
    
    echo "${GREEN}--- data sent to connected processes:${NC}"
    cat /tmp/data_sent_to_connected_processes.txt
}

function watch_specific_process_for_sent_data() {
    if [ -z "$1" ]; then
        echo "${RED}--- please provide a process name to watch.${NC}"
        return
    fi
    
    echo "${GREEN}--- watching process '$1' for sent data${NC}"
    
    # Use lsof to monitor the specified process for network connections
    lsof -i -n | grep "$1" | grep ESTABLISHED | awk '{print $1, $2, $9}' | sort | uniq > /tmp/watched_process_data.txt
    
    # Check if the file is empty
    if [ ! -s /tmp/watched_process_data.txt ]; then
        echo "${RED}--- no data sent by process '$1' found.${NC}"
        return
    fi
    
    echo "${GREEN}--- data sent by process '$1':${NC}"
    cat /tmp/watched_process_data.txt
}