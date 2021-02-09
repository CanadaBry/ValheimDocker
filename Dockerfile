FROM debian:buster

# download requirements
RUN apt-get -y update && \
    apt-get -y install lib32gcc1 lib32stdc++6 curl && \
    apt-get clean && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV PUID=1000
ENV PGID=1000

# setup steam user
RUN groupadd --gid "${PGID}" -r steam 
RUN useradd -u "${PUID}" -r -g "${PGID}" -m -d /home/steam -c "Valheim server user" steam
WORKDIR /home/steam

RUN mkdir server_scripts
COPY server.sh server_scripts/

# download steamcmd
RUN mkdir steamcmd && cd steamcmd && \
    curl "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf -

# start steamcmd to force it to update itself
RUN ./steamcmd/steamcmd.sh +quit && \
    mkdir -pv /home/steam/.steam/sdk32/ && \
    ln -s /home/steam/steamcmd/linux32/steamclient.so /home/steam/.steam/sdk32/steamclient.so

# start the server main script
ENTRYPOINT ["bash", "/home/steam/server_scripts/server.sh"]

