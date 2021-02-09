#!/bin/bash

usermod -u ${PUID} steam
groupmod -g ${PGID} steam
su -s /bin/bash -c 'id' steam

# update server's data
/home/steam/steamcmd/steamcmd.sh \
	    +login anonymous \
	        +force_install_dir /home/steam/server_data \
		    +app_update 896660 \
		        +exit

#Copy 64bit steamclient, since it keeps using 32bit
cp /home/steam/steamcmd/linux64/steamclient.so /home/steam/server_data

#Apply default values for server if not set
SERVER_NAME=${SERVER_NAME:-My\ server}
SERVER_PORT=${SERVER_PORT:-2456}
SERVER_WORLD=${SERVER_WORLD:-Dedicated}
SERVER_PASSWORD=${SERVER_PASSWORD:-secret}

#Trap Container Stop for graceful exit
trap "echo 1 > server_exit.drp;" SIGTERM

#Launch server
export LD_LIBRARY_PATH=./linux64:$LD_LIBRARY_PATH
export SteamAppId=892970
/home/steam/server_data/valheim_server.x86_64 -name "$SERVER_NAME" -port $SERVER_PORT -world "$SERVER_WORLD" -password "$SERVER_PASSWORD" -public 1 & 

#Wait for server to exit
while wait $!; [ $? != 0 ]; do true; done
