Simple docker setup that runs ROS Noetic and rviz without Nvidia drivers 
Sudo privileges are most likely needed to run

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
``

Attach to the container:
```
docker exec -it <CONTAINER_NAME> bash
```

