# mongodb-docker-compose

Step 1:-


Create a directory with the name you want then, inside, create a file called docker-compose.yml and add the code below

version: '3.3'

services:
  mongoA:
    container_name: mongoA
    image: mongo:4.4
    volumes:
      - ~/mongors/dataA:/data/db
      - ./rs-init.sh:/home/ec2-user/docker-mongodb/rs-init.sh
    networks:
      - mongors-network
    ports:
      - 27021:27017
    links:
      - mongoB
      - mongoC
    restart: always
    entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "dbrs" ]
  mongoB:
    container_name: mongoB
    image: mongo:4.4
    volumes:
      - ~/mongors/dataB:/data/db
    networks:
      - mongors-network
    ports:
      - 27022:27017
    restart: always
    entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "dbrs" ]
  mongoC:
    container_name: mongoC
    image: mongo:4.4
    volumes:
      - ~/mongors/dataC:/data/db
    networks:
      - mongors-network
    ports:
      - 27023:27017
    restart: always
    entrypoint: [ "/usr/bin/mongod", "--bind_ip_all", "--replSet", "dbrs" ]

networks:
  mongors-network:
    driver: bridge

    
    
    
    
    
 Step 2:-   
    
    
We created three Docker containers from MongoDB images. On the first container, in addition to the volume folder for database data, we map the file in the host called rs-init.sh to the container at the location /scripts/rs-init.sh. This file will contain the command.

Connect to the mongo instance
Configure the replica set configure
Exit
So let's create this file and add the code below:    
    
    
#!/bin/bash

mongo <<EOF
var config = {
    "_id": "dbrs",
    "version": 1,
    "members": [
        {
            "_id": 1,
            "host": "mongoA:27017",
            "priority": 3
        },
        {
            "_id": 2,
            "host": "mongoB:27017",
            "priority": 2
        },
        {
            "_id": 3,
            "host": "mongoC:27017",
            "priority": 1
        }
    ]
};
rs.initiate(config, { force: true });
rs.status();
EOF



Make this file executable by running the command: chmod +x rs-init.sh



Step 3:-

Now create another file called startdb.sh and the code below inside:


#!/bin/bash

docker-compose up -d

sleep 5

docker exec mongoA /home/ec2-user/docker-mongodb/rs-init.sh


Make this file executable by running the command: chmod +x startdb.sh



Step 4:-
Below is the description of what we do in this file:

Run the Docker-compose file to start our container in the background.
Wait for five seconds for the container to be ready.  
Connect to docker container mongo1 and execute the file rs-init.sh.
Now, when you want to work, run: ./startdb.sh
When you finished and want to stop everything: docker-compose down


    
