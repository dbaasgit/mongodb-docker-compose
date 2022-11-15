#!/bin/bash

docker-compose up -d

sleep 5

docker exec mongoA /home/ec2-user/docker-mongodb/rs-init.sh
