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
