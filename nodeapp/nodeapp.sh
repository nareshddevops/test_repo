#!/bin/sh

GIT_REPO_URL="https://github.com/nareshddevops/nodeapp.git"
USER="testuser"
API_KEY="4567"
CONNECTION_STRING="remote.host.com:8080"
IP_ADDRESS="remote.host.com"

# checkout code from github
cd /home/testuser/
git clone $GIT_REPO_URL mycode

# Update config.json with variables
/usr/bin/python3 /home/testuser/code/nodeapp/jsonupdate.py $USER $API_KEY $CONNECTION_STRING $IP_ADDRESS
# Change the ownership of the code directory
chown -R testuser:testuser /home/testuser/mycode
# Archive folder and scp to remote machine
tar -czf app.tar.gz -C mycode .
md5sum app.tar.gz > appfiles.md5

scp app.tar.gz appfiles.md5 testuser@remote.test.com:/home/testuser/remotecode

# Execute the commands remotely
ssh -T testuser@remote.test.com << EOF
    sudo systemctl stop node
    mv /home/testuser/remotecode/app.* /user/node/data/
    cd /user/node/data/
    tar -xf app.tar.gz
    sudo systemctl start node
EOF

# Check the status code
sleep 1s
status="$(curl --connect-timeout 5 --write-out %{http_code} --silent --output /dev/null http://remote.test.com/status)"
echo "Status : $status"
