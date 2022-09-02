sudo podman run --rm -i -e PGID=$(id -g) -e PUID=$(id -u) -v "/home/login/Downloads/yt-dl":/workdir:z mikenye/youtube-dl <url>
