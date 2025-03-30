Simple docker setup that runs ROS Noetic and rviz without needing to install nvidia drivers.

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

