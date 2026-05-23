#!/bin/bash
PORT=$((1024 + RANDOM % 8875))
docker run -d --rm -p ${PORT}:7681 --name pi-ttyd-${PORT} -v ./pi-data:/home/node/.pi -v ./workspace:/workspace pi-ttyd
open http://127.0.0.1:${PORT}
