#!/bin/bash

# update server's data
/home/steam/steamcmd/steamcmd.sh \
	    +login anonymous \
	        +force_install_dir /home/steam/server_data \
		    +app_update 896660 \
		        +exit

cp /home/steam/steamcmd/linux64/steamclient.so /home/steam/server_data

# start the server
SERVER_NAME=${SERVER_NAME:-My\ server}
SERVER_PORT=${SERVER_PORT:-2456}
SERVER_WORLD=${SERVER_WORLD:-Dedicated}
SERVER_PASSWORD=${SERVER_PASSWORD:-secret}

export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

rm -f /home/steam/server_data/server_exit.drp
trap "echo 1 > server_exit.drp;exit 1" SIGTERM

/home/steam/server_data/valheim_server.x86_64 -name "$SERVER_NAME" -port $SERVER_PORT -world "$SERVER_WORLD" -password "$SERVER_PASSWORD" -public 1 &

read;
