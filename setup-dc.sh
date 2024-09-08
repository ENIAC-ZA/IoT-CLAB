#!/bin/bash

# Global Settings
SPINE1=spine1

IP_CTRL=172.10.10.10
IP_PORT=6653

OF_VER=OpenFlow13
FAIL_MODE=secure

ACTIVE_TIMEOUT=10

echo Create switches
ovs-vsctl --may-exist add-br $SPINE1

echo Set switch options
for BR in $SPINE1 
do
  ovs-vsctl set bridge $BR fail_mode=$FAIL_MODE
  ovs-vsctl set bridge $BR protocols=$OF_VER
  ovs-vsctl set-controller $BR tcp:$IP_CTRL:$IP_PORT
done

echo Setup NetFlow
for BR in $SPINE1
do
  ovs-vsctl -- --id=@ipfix create IPFIX "targets=\"192.168.1.160:9996\"" sampling=100 obs_domain_id=1 obs_point_id=1 -- set Bridge $BR ipfix=@ipfix
done

# uncomment the following if you want to use sflow
# echo Setup sflow
# for BR in $SPINE1 $SPINE2 $LEAF1 $LEAF2 $LEAF3
# do
#   ovs-vsctl -- --id=@sflow create sflow agent=$BR target=$SFLOW \
#     sampling=100 polling=10 -- set bridge $BR sflow=@sflow
# done
