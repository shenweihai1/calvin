mkdir -p /dev/shm/zookeeper;
mkdir -p /dev/shm/zookeeper; echo "$1" > /dev/shm/zookeeper/myid

/home/rolis/zookeeper-3.4.12/bin/zkServer.sh start
#/home/azureuser/zookeeper-3.4.12/bin/zkCli.sh -server 10.1.0.7:2181 rmr /root
