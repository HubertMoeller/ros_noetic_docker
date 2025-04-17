# Docker setup for running ROS Noetic with graphical support and connection to remote ROS master
Docker setup that runs ROS Noetic and RViz without needing to install Nvidia drivers. This setup also allows for remote connection to a ROS master on another host machine. This project was used for connecting remotely to a Husky robot and displaying the topics in RViz.

## Install Docker Engine

Docker engine can be installed by following this guide: https://docs.docker.com/engine/install/

Note: Make sure to install Docker Engine and not Docker Desktop, as Docker Desktop doesn't have good support for GUI

## Set up networking for using container as remote ROS instance

Set up the ROS network configurations as below:

1. Connect both machines to the same network, preferrably one with support for static IP addresses as then you won't have to perform the setup every time
2. Find IP addresses of host and remote machine.
    To see IP adresses use ``$ ìfconfig`` or for a more simple approach use ``$ hostname -I`` on both machines
    On terminal of ROS master PC:
    ```bash
    $ export ROS_IP=ip_of_master
    $ export ROS_MASTER_URI=http://ip_of_master:11311
    ```
    On remote PC:
    Go to .env file and edit the file to include the correct IP addresses

    ```
    ROS_MASTER_URI=ip_of_master
    ROS_IP=ip_of_remote
    ```
3. To add this permanently to the master, modify `/etc/ros/setup.bash` on master: Add `export ROS_MASTER_URI=http://ip_of_master:11311` and `export ROS_IP=ip_of_master`
4. Now build and spin up the container on the remote machine as explained in the section below
5. Inside the container, try running ``rostopic list`` to see the topics from the master are visible. If this doesn't work try using another IP from the ``$ hostname -I`` command
6. Try to see if you can read the the data of the topics with ``$ rostopic echo <name_of_topic``
7. If firewall is blocking the connection disable it with `ufw disable`

In case the topics can be seen but not read (no output when using rostopic echo), the Husky ros nodes likely use a hostname for publishing.
1. See hostname used for Husky nodes:
    ```bash
    rosnode info <node-names>
    ```
1. Add the hostname to the .env file, and restart the container
    ```
    ROS_HOSTNAME=hostname_of_master
    ```


## Building image and spinning up container
Build image with:
```
docker compose build dev
```

Afterwards spin up container with
```
docker compose up dev
```

Find name of container:
```
docker ps
```

Attach to the container:
```
docker exec -it <CONTAINER_NAME> bash
```

## Other useful stuff
To open rviz with custom configuration file, type in bash of container:
```
rviz -d /overlay_ws/my_config.rviz
```
The folder /bags/ is mounted to the container and can be used for saving files locally on the machine
```bash
$ cd /overlay_ws/bags
```


