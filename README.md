# ValheimDocker

Automatically runs a Valheim dedicated server.

Uses the following Environment Variables:

SERVER_NAME #Name on the server list

SERVER_PORT #Port the server run on. Be aware, this uses the provided port number and the 2 following ports. Example: specifying port 1234 uses 1235 and 1236 as well.

SERVER_WORLD #Name of the world file to load

SERVER_PASSWORD #Password to join game

The server uses UDP for all 3 ports.

If you want your server and worlds to be persistent link these folders:

/home/steam/server_data #Where steamcmd downloads the game files

/home/steam/.config/unity3d/IronGate/Valheim #Where your worlds, banlist, etc lives


Dockerfile is a modified version from https://github.com/respawner/docker-steamcmd

## Example

```
docker build -t valheim .
docker run -d --name=valheim \
    -v /opt/valheim/data:/home/steam/server_data \
    -v /opt/valheim/scripts:/home/steam/.config/unity3d/IronGate/Valheim \
    -p 0.0.0.0:2456:2456/udp \
    -p 0.0.0.0:2457:2457/udp \
    -p 0.0.0.0:2458:2458/udp \
    -e SERVER_NAME="Valheim Docker" \
    -e SERVER_PORT=2456 \
    -e SERVER_PASSWORD="secret" \
valheim:latest
```
