
### SDN Topo
![SDN-API-Topo](https://github.com/user-attachments/assets/d61ee5f2-8fa4-4345-9473-4a515bdb76af)
### My Topology
![Topology](https://github.com/user-attachments/assets/7551aadc-f51e-47dd-b6b7-b89e153d69f5)
### SDN initial request
![initialrequest](https://github.com/user-attachments/assets/8676cc61-9c5d-4102-b832-77b893c9795c)
## SDN With matching flow record
![subrequest](https://github.com/user-attachments/assets/f54dbe1e-1d61-442f-babb-6c5e3c5a677b)

# Simple Software Defined Lab With Simulated IoT devices

  

This lab creates a software-defined switch & router network built with Open-vSwitch & FRRouting as well as some simulated IoT devices.

  

This setup will only work on Linux hosts.

  

To use this lab, you need to install the following:

- containerlab  https://containerlab.dev/install/#package-managers

- docker-ce  https://docs.docker.com/engine/install/ubuntu/

- Open vSwitch https://docs.openvswitch.org/en/latest/intro/install/distributions/#debian-ubuntu

  

  

## Docker images used:

  

### running on containerlab

- martimy/ryu-flowmanager:latest — includes a [Ryu](https://github.com/faucetsdn/ryu) controller and [FlowManager](https://github.com/martimy/flowmanager).

- wbitt/network-multitool:alpine-minimal — a Linux with simple tools

- frrouting/frr:latest - Free Range Routing or FRRouting or FRR is a network routing software suite running on Unix-like platforms, particularly Linux, Solaris, OpenBSD, FreeBSD and NetBSD

  

### kafka stack running on docker

- confluentinc/cp-zookeeper:6.1.1

- confluentinc/cp-kafka:6.1.1

- confluentinc/cp-kafka:6.1.1

- confluentinc/cp-kafka:6.1.1

- confluentinc/cp-schema-registry:6.1.1

- confluentinc/cp-kafka-connect-base:6.1.4

- confluentinc/cp-kafka:6.1.1

- provectuslabs/kafka-ui

  

### elastiflow running on docker

- elastiflow/flow-collector:7.1.1

  







## Starting and ending the lab

#### I recommend keeping elastiflow & kafka deployed, and only creating/destroying/recreating the Bridge/vSwitch/Clab if you want to test changes quickly.

  
  

Register here for an elastiflow license - https://www.elastiflow.com/basic-license

Once you have recieved your license via email, place it in your elastiflow docker-compose.yaml located at `flowcoll/docker-compose.yaml`
![image](https://github.com/user-attachments/assets/f5cc0978-fc6f-4502-af61-1c14aa840d17)

### Build Docker Images

```

sh ./build-images.sh

```



### Start elastiflow

```

cd flowcoll/

docker-compose up -d

cd ..

```

  

### Start Kafka

```

cd kafka/

docker-compose up -d

cd ..

```

  
  
  

### Create Bridge(*`setup-bridge.sh`*) & vSwitch(`setup-dc.sh`), then deploy the lab(`clab deploy`):

  

```

./setup-bridge.sh

sudo ./setup-dc.sh

sudo clab deploy -t sdn-dcn.clab.yml

```

  
  

## To end the lab(`clab destory`) and remove the vSwitch(`reset-dc.sh`) & Bridge(`ip link del`) :

```

sudo clab destroy -t sdn-dcn.clab.yml --cleanup

sudo ./reset-dc.sh

sudo ip link del brdg

```

  

## Stop Kafka

```

cd kafka/

docker-compose down

cd ..

```

  

## Stop elastiflow

```

cd flowcoll/

docker-compose down

cd ..

```

  
  

## Try this

  

### Check the controller

  

Confirm that all switches are connected to the controller:

  

```

$ sudo ovs-vsctl show

6324bfc8-4c27-4eb1-852d-bc560406943e

Bridge spine1

Controller "tcp:172.10.10.10:6653"

is_connected: true

  

<remaining output omitted>

```

  

### To access the FlowManager/SDN-Controller GUI remotely use:

Replace user@remotehost with the username and address of your host machine.

  

```

ssh -L 8080:172.10.10.10:8080 -p 22 user@remotehost

```

You should now be able to navigate to: http://localhost:8080/home/index.html

  

![image](https://github.com/user-attachments/assets/f9f6ad52-30c4-4189-add0-8ae6ff705a3a)

  
  

You can test API calls by looking at examples in api-script-examples/

### To access the KAFKA GUI :
`remotehost:8070`

  

### Running an commands on "IoT" containers

  
  
  

To test connectivity, ping from any one host to another:

  

```

$ docker exec -it clab-sdn-dcn-h11 ping 192.168.1.6

PING 192.168.1.6 (192.168.1.6) 56(84) bytes of data.

64 bytes from 192.168.1.6: icmp_seq=1 ttl=64 time=0.112 ms

64 bytes from 192.168.1.6: icmp_seq=2 ttl=64 time=0.024 ms

64 bytes from 192.168.1.6: icmp_seq=3 ttl=64 time=0.125 ms

64 bytes from 192.168.1.6: icmp_seq=4 ttl=64 time=0.066 ms

64 bytes from 192.168.1.6: icmp_seq=5 ttl=64 time=0.031 ms

^C

--- 192.168.1.6 ping statistics ---

5 packets transmitted, 5 received, 0% packet loss, time 4090ms

```

  

Observe the change in the flow tables in the switches.

  
  

### Modifying the SDN App

  

You can change the SDN app that controlles the network by modifying the ENTRYPOINT of the controller image in the YAML topology file:

  

```

entrypoint: ryu-manager flowmanager/simple_switch_13.py <app>

```

  

You must destory then deploy the topology again to apply the change (or use docker commands). However, I don't recommed using this lab to develop SDN applications. You may need different environment more sutiable for this purpose.

  
  

## How does it work?

  

This lab builds an SDN using [Open vSwitch](https://www.openvswitch.org/) (OVS) and [Docker](https://www.docker.com/) containers. These components are "glued" together using [containerlab](https://containerlab.dev/).

  

The Open vSwitch is an open-source virtual switch that is included in many Linux distributions. OVS is designed to work as a standalone switch that supports many standard management interfaces and protocols. OVS can also work as an SDN switch supporting OpenFlow protocol.

  

As an OpenFlow switch, the OVS needs an SDN controller. The SDN controller used in this lab is [Ryu](https://ryu-sdn.org/). Ryu is installed in a Docker image along with FlowManager app, which provides a GUI access to the switches.

  

Switch/Router is emulated using a Docker image with pre-installed tools for testing.

  

Containerlab provides mechanisms to start Docker containers, build virtual topologies, and manage their lifecycle. A lab structure is provided in a YAML file that includes the containers to be deployed and their connections. However, containerlab, cannot create bridges (standard or OVS) other than the management bridge. Therefore, the bridges in this lab must be created externally using a shell script before deploying the containerlab topology. Also, another shell script is required to delete all bridges at the end of the lab.

  


## Useful Links

  

- [Containerlab](https://containerlab.dev/)

- [OpenFlow](https://opennetworking.org/software-defined-standards/specifications/)

- [Ryu controller docs](https://ryu.readthedocs.io/en/latest/)

- [Ryu controller code](https://github.com/faucetsdn/ryu)

- [FlowManager](https://github.com/martimy/flowmanager)

- [Open vSwitch](https://www.openvswitch.org/)

- [sflow/open vswitch](https://docs.openvswitch.org/en/latest/howto/sflow/)

- [sflowtrend Docker image](https://hub.docker.com/r/sflow/sflowtrend/)



