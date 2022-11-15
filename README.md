# mongodb-docker-compose

Step 1:-


Create a directory with the name you want then, inside, create a file called docker-compose.yml and add the code below


 Step 2:-   
    
    
We created three Docker containers from MongoDB images. On the first container, in addition to the volume folder for database data, we map the file in the host called rs-init.sh to the container at the location /home/ec2-user/docker-mongodb/rs-init.sh. This file will contain the command.

Connect to the mongo instance

Configure the replica set configure

Exit

Make this file executable by running the command: chmod +x rs-init.sh

Step 3:-

Now create another file called startdb.sh and the code given as in startdb.sh


Make this file executable by running the command: chmod +x startdb.sh

Step 4:-

Below is the description of what we do in this file:

Run the Docker-compose file to start our container in the background.

Wait for five seconds for the container to be ready.  

Connect to docker container mongo1 and execute the file rs-init.sh.

Now, when you want to work, run: ./startdb.sh

When you finished and want to stop everything: docker-compose down

    
