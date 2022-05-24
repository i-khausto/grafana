#!/bin/bash

apt update
apt upgrade -y

apt-get install -y apt-transport-https curl gnupg wget curl

echo "[INFO 1] Granfana installing..."
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
apt update
apt install -y grafana
systemctl start grafana-server
systemctl enable grafana-server

echo "[INFO 2] InfluxDB installing..."
echo "deb https://repos.influxdata.com/ubuntu bionic stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
apt update
apt install -y influxdb
apt install -y influxdb-client
systemctl enable --now influxdb

echo "[INFO 3] Database creation"
curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE network"

echo "[INFO 4] Metrics are sending  to grafana..."

curl -X POST 'http://localhost:8086/write?db=network' --data-binary "icmp,host=Google.com,ip=localhost value=123"

curl -X POST 'http://localhost:8086/write?db=network' --data-binary "icmp,host=Google.com,ip=localhost value=$(curl "google.com" -s -o /dev/null -w "%{time_total}")"


