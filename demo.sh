#!/bin/bash

redis_server="vagrant@192.168.1.10"
go_client="vagrant@192.168.1.20"
python_client="vagrant@192.168.1.30"

echo "==================================================================================="
echo "Starting Redis DB server on redis_server (192.168.1.10)"
echo "==================================================================================="
ssh $redis_server './redis-3.0.1/src/redis-server 1> /tmp/output 2> /tmp/error &'

if [ $? -ne 0 ]
then
   echo "Error starting Redis DB server"
   exit 0
fi
echo "========"
echo "Success."
echo "========"

sleep 10
echo "==================================================================================="
echo "Starting demonstration for go-lib for Storing and Retreiving URLs from Redis DB"
echo "Demonstrating from go_client (192.168.1.20)"
echo "==================================================================================="
sleep 10
ssh $go_client 'cd ~/go-lib && export GOPATH=`pwd` && make -B && ./demo.out'

if [ $? -ne 0 ]
then
   echo "Error starting Go-lib demo"
   exit 0
fi
echo "========"
echo "Success."
echo "========"

sleep 10
echo "==================================================================================="
echo "Starting demonstration for python-lib for Storing and Retreiving URLs from Redis DB"
echo "Demonstrating from python_client (192.168.1.30)"
echo "==================================================================================="
sleep 10
ssh $python_client 'cd ~/python-lib && python demo.py'

if [ $? -ne 0 ]
then
   echo "Error starting python-lib demo"
   exit 0
fi
echo "========"
echo "Success."
echo "========"

sleep 10
echo "==================================================================================="
echo "Stopping Redis DB server on redis_server (192.168.1.10)"
echo "==================================================================================="
sleep 10
ssh $redis_server 'pkill redis-server &'

if [ $? -ne 0 ]
then
   echo "Error stopping Redis DB server"
   exit 0
fi
echo "========"
echo "Success."
echo "========"

sleep 5
echo -e "End of Demonstration!\nThank you!"
