#!/bin/bash
echo "executing script"
sudo apt-get update -y
sudo apt-get install default-jre -y
sudo apt-get install apache2 -y
echo "entering html"
chmod 777 /var/www/html
sudo cp my-app-1.0-SNAPSHOT.110.jar /var/www/html
ls
echo "deploying app"
cd  /var/www/html
ls
sudo rm index.html
echo "ls inside"
ls
nohup java -jar my-app-1.0-SNAPSHOT.110.jar > index.html 2>&1 &