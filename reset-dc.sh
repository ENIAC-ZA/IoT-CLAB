#!/bin/bash

# Remove all switches
ovs-vsctl --if-exists del-br spine1
sudo ip link delete eth1
sudo ip link delete eth3