#!/bin/bash

echo "Deploying..."

SERVICE="monitor-api.service"
DEPLOY_PATH="/opt/monitor_api"

sudo mkdir $DEPLOY_PATH
cp * $DEPLOY_PATH
cd $DEPLOY_PATH

sudo ~/nginx_deploy_virtual_hosts.sh counter.com
cp ./index.html /var/www/counter.com/html

echo "Building app..."

go mod download
go build -o counter

echo "Built"
echo "Creating db..."
./counter --createdb

echo "Starting service..."

cp ./$SERVICE /etc/systemd/system/$SERVICE
sudo chmod +x ./monitor-api.sh

sudo systemctl enable $SERVICE
sudo systemctl start $SERVICE
sudo systemctl status $SERVICE


echo "Deployed successfully!"