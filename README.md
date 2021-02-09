# ValheimDocker

A docker application designed to host a dedicated server for the Early Access game **Valheim**. You can find an up-to-date image on my [DockerHub](https://hub.docker.com/r/wilso224/valheim_dedicated_server).

Please see below on how to build and/or run this image on your machine.

## Configuration

### Environment Variables

Currently there are 4 environment variabels youc an set to configure the server.

Variable | Description
------------ | -------------
SERVER_NAME | The name listed in the server browser
SERVER_PORT | The port that the game should run on.
SERVER_WORLD | The world file you would like the server to load
SERVER_PASSWORD | Password to enter server. This currently cannot be blank

### Network Setup

* The server runs on 3 ports, they are sequential to the supplied SERVER_PORT.
* All 3 of these ports communicate using UDP
* SERVER_PORT+1 is the port that listens for new connections

If you set your `SERVER_PORT=2456`, this mean you will be using ports 2456, 2457, 2458 and your server will be listening on port 2457.

### Volumes

Currently there are 2 volumes you will need to mount:

`/home/steam/server_data` *This is the install directory for the server from steamcmd*

`/home/steam/.config/unity3d/IronGate/Valheim` *This is where the game stores your world files and banlist, etc.*

Be sure to create the directories on your host machine before mounting them with Docker or this will result in a *Disk Write Failure* from steamcmd.

*If you already ran the docker before creating the directories run `sudo chown $(id -u) scripts/ data/` to take ownership of the folders. Restart the container and it should work now.*


## Example

To use the `docker-compose.yml` run the following commands.

```
mkdir scripts/ data/
docker-compose up -d
```

You can use this command to build the image and run the code. 

```
docker build -t valheim .
mkdir -p /opt/valheim/data /opt/valheim/scripts
docker run -d --name=valheim \
    -v /opt/valheim/data:/home/steam/server_data \
    -v /opt/valheim/scripts:/home/steam/.config/unity3d/IronGate/Valheim \
    -p 0.0.0.0:2456:2456/udp \
    -p 0.0.0.0:2457:2457/udp \
    -p 0.0.0.0:2458:2458/udp \
    -e SERVER_NAME="Valheim Docker" \
    -e SERVER_PORT=2456 \
    -e SERVER_PASSWORD="secret" \
    -e SERVER_WORLD="Dedicated" \
valheim:latest
```

**Please use `docker container stop` to shutdown the server and avoid rollbacks**

## Thanks to

[Respawner](https://github.com/respawner) - For the base `DockerFile` used for the image in [docker-steamcmd](https://github.com/respawner/docker-steamcmd)

[bearlikelion](https://github.com/bearlikelion) - For the `docker-compose.yml` and example commands.
