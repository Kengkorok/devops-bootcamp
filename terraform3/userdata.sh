#!/bin/bash
curl -fsSL https://get.docker.com | sh
id ssm-user &> /dev/null || useradd -m ssm-user
usermod -aG docker ssm-user
docker run -d -p 80:80 nginx
