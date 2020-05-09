#!/bin/sh

GIT_REPO_URL = ""
USER = ""
API_KEY = ""
CONNECTION_STRING = ""
IP_ADDRESS = ""

# checkout code from github
mkdir -p /home/testuser/mycode/
cd /home/testuser/mycode/
git clone $GIT_REPO_URL

# Update config.json with variables
/usr/bin/python jsonupdate.py $USER $API_KEY $CONNECTION_STRING $IP_ADDRESS
# Change the ownership of the code directory
chown -R testuser /home/testuser/mycode
# Archive folder and scp to remote machine
tar -czf app.tar.gz /home/testuser/mycode/
md5sum app.tar.gz > appfiles.md5
scp app.tar.gz appfiles.md5 testuser@remote.test.com:/home/testuser/remotecode/

# Execute the commands remotely
ssh testuser@remote.test.com << EOF
    systemctl stop node
    mv /home/testuser/remotecode/app.* /user/node/data/
    tar -xf app.tar.gz
    systemctl start node
EOF

# Check the status code
status=$(curl --connect-timeout 5 --write-out %{http_code} --silent --output /dev/null ​http://remote.test.com/status)
if [[ "$status" -ne 200 ]] ; then
  echo "status : 200"
else
  ssh testuser@remote.test.com "systemctl restart node" 
fi
