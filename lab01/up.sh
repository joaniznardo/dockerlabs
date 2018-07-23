#!/bin/bash

docker-compose up -d
sleep 10


#############################
###### client-2 ######
#############################

docker exec client-2 /bin/bash -c "route del default;route add default gw 9.1.0.102 eth0; route"

#############################
###### client-1 ######
#############################

docker exec client-1 /bin/bash -c "route del default;route add default gw 10.1.0.101 eth0; route"



#############################
###### router-1 ######
#############################

docker cp router-1-config.boot router-1:/config.boot.template
docker exec router-1 cp  /config.boot.template  /config/config.boot

INTERFACE_NAME=`docker exec router-1 ifconfig | grep -B1 "HWaddr 02:42:0a:01:00:65"  | awk '{print $1}' | xargs`
docker exec router-1 sed -i.bak s/PLACEHOLDER_02:42:0a:01:00:65/$INTERFACE_NAME/g /config/config.boot

INTERFACE_NAME=`docker exec router-1 ifconfig | grep -B1 "HWaddr 02:42:08:01:00:65"  | awk '{print $1}' | xargs`
docker exec router-1 sed -i.bak s/PLACEHOLDER_02:42:08:01:00:65/$INTERFACE_NAME/g /config/config.boot

docker exec router-1 /etc/init.d/vyatta-router restart

#############################
###### router-2 ######
#############################

docker cp router-2-config.boot router-2:/config.boot.template
docker exec router-2 cp  /config.boot.template  /config/config.boot

INTERFACE_NAME=`docker exec router-2 ifconfig | grep -B1 "HWaddr 02:42:07:01:00:66"  | awk '{print $1}' | xargs`
docker exec router-2 sed -i.bak s/PLACEHOLDER_02:42:07:01:00:66/$INTERFACE_NAME/g /config/config.boot

INTERFACE_NAME=`docker exec router-2 ifconfig | grep -B1 "HWaddr 02:42:09:01:00:66"  | awk '{print $1}' | xargs`
docker exec router-2 sed -i.bak s/PLACEHOLDER_02:42:09:01:00:66/$INTERFACE_NAME/g /config/config.boot

INTERFACE_NAME=`docker exec router-2 ifconfig | grep -B1 "HWaddr 02:42:08:01:00:66"  | awk '{print $1}' | xargs`
docker exec router-2 sed -i.bak s/PLACEHOLDER_02:42:08:01:00:66/$INTERFACE_NAME/g /config/config.boot

docker exec router-2 /etc/init.d/vyatta-router restart

#############################
###### router-3 ######
#############################

docker cp router-3-config.boot router-3:/config.boot.template
docker exec router-3 cp  /config.boot.template  /config/config.boot

INTERFACE_NAME=`docker exec router-3 ifconfig | grep -B1 "HWaddr 02:42:07:01:00:02"  | awk '{print $1}' | xargs`
docker exec router-3 sed -i.bak s/PLACEHOLDER_02:42:07:01:00:02/$INTERFACE_NAME/g /config/config.boot

docker exec router-3 /etc/init.d/vyatta-router restart


####################################################
###### Fix network problems on docker-machine ######
####################################################

docker-compose restart
sleep 4

docker exec router-1 service ssh restart 
docker exec router-2 service ssh restart 
docker exec router-3 service ssh restart 

docker exec client-2 service ssh restart 
docker exec client-1 service ssh restart 