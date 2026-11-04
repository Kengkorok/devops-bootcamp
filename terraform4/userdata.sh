#!/bin/bash
set -euo pipefail

# 1) Docker (sama macam terraform3/userdata.sh - convenience script Docker)
#    Skrip ni install docker-ce, CLI, containerd, buildx DAN docker-compose-plugin,
#    jadi arahan "docker compose" terus boleh guna.
curl -fsSL https://get.docker.com | sh

# 2) User ssm-user untuk sesi SSM (Session Manager login sebagai ssm-user)
id ssm-user &> /dev/null || useradd -m ssm-user
usermod -aG docker ssm-user

# 3) Tunggu daemon docker betul-betul sedia sebelum compose up
for i in $(seq 1 30); do
  docker info > /dev/null 2>&1 && break
  sleep 2
done

# 4) Rackula - ikut resepi rasmi https://github.com/RackulaLives/Rackula
#    deploy/docker-compose.persist.yml (UI nginx :8080 + API :3001 dalam container)
mkdir -p /opt/rackula
cd /opt/rackula
curl -fsSL https://raw.githubusercontent.com/RackulaLives/Rackula/main/deploy/docker-compose.persist.yml -o docker-compose.yml

# API jalan sebagai UID 1001 dan tulis layout ke ./data
mkdir -p data
chown 1001:1001 data

docker compose up -d
