# Test Scripts
Clone this repository to execute the test scripts locally.

## Prerequisites to execute test scripts
- \*nix platform
- Python
- Git
- Node.js

## Scripts:

### 1. Python script to reverse a string “abcdef” --> “fedcba”

##### Run below command in linux terminal to execute the script
 ```shell
 cd reverse_string
 python reverse_string.py
 ```
##### Execution Flow:
- Assign the string *'abcdef'*  to *'mystr'* variable
  ```python
  mystr = 'abcdef'
  ```
- Find the length of the *'mystr'* and minus it with *'1'* to get the last index number of the string and assign that value to a variable *'counter'*
  ```python
  counter = len(mystr) - 1
  ```
- Create an empty string variable *'new_str'* to store the reverse string value
  ```python
  new_str = ''
  ```
- While loop will loop through the *'counter'* variable till the value of it is greater than or equal to *'0'* and inside loop concatenate the string char with index number as *'counter'* with the *'new_str'* variable and assign to *'new_str'* and minus the *'counter'* value with *'1'*. At the end of the while loop *'new_str'* will contain the reverse value of *'mystr'*
  ```python
  while counter >= 0: **
      new_str += mystr[counter]
      counter -= 1
  ``` 
- After the while loop, print *'new_str'* variable value to console
  ```python
  print(new_str)
  ```

### 2. Python script that can parse an integer array and verify that it is of social security number format

##### Run below command in linux terminal to execute the script
 ```shell
 cd ssn_validation
 python validate_ssn.py
 ```
 ##### Execution Flow:
- Get SSN number from input statement and assign the value to *'ssn_num'* variable
  ```python
  ssn_num = input('Enter your SSN number (123-45-6789):')
  ```
- Split the *'ssn_num'* value with delimiter *'-'* and assign the list to variable *'ssn_slice'*
  ```python
  ssn_slice = ssn_num.split('-')
  ```
- With if statement check the length of the list *'ssn_slice'* is equal to *'3'*. If the condition is True, with the nested if statement check the length of the three values inside list is equal to 3, 2, 4 respectively. If the nested if condition is True, print *'Valid SSN number'*, If the nested condition is False print *'Invalid SSN number format'*.
  ```python
  if len(ssn_slice) == 3: 
    if len(ssn_slice[0]) == 3 and len(ssn_slice[1]) == 2 and len(ssn_slice[2]) == 4:
        print('Valid SSN number')
    else:
        print('Invalid SSN number format')
  else:
    print('Invalid SSN number format')
  ``` 
### 3. Shell script to deploy node app

##### Run below command in linux terminal to execute the script
 ```shell
 cd nodeapp
 chmod +x nodeapp.sh
 sh nodeapp.sh
 ```
##### Execution Flow:
- Assign actual values to the variables like GIT_REPO_URL, USER, API_KEY, CONNECTION_STRING, IP_ADDRESS.
  ```shell
  GIT_REPO_URL = ""
  USER = ""
  API_KEY = ""
  CONNECTION_STRING = ""
  IP_ADDRESS = ""
  ```
- Clone the github code into *'mycode'* directory
  ```shell
  cd /home/testuser/
  git clone $GIT_REPO_URL mycode
  ```
- Execute *'jsonupdate.py'* python script to update the *'config.json'* objects with the respective variables by passing variables as an arguments to the python script
  ```shell
  /usr/bin/python3 /home/testuser/code/nodeapp/jsonupdate.py $USER $API_KEY $CONNECTION_STRING $IP_ADDRESS
  ```
  *'jsonupdate.py'* script will update objects of the *'config.json'* file inside the *'mycode'* directory if they are empty.
  ```python
  import sys, json
  tmp_file = open("/home/testuser/mycode/config.json", "r")
  json_object = json.load(tmp_file)
  tmp_file.close()
  
  if not json_object['user']:
    json_object["user"] = sys.argv[1]
  if not json_object["api_key"]:
    json_object["api_key"] = sys.argv[2]
  if not json_object["conn_string"]:
    json_object["conn_string"] = sys.argv[3]
  if not json_object["ip_address"]:
    json_object["ip_address"] = sys.argv[4]

  tmp_file = open("/home/testuser/mycode/config.json", "w")
  json.dump(json_object, tmp_file)
  tmp_file.close()
  ```
- Change the ownership of the *'mycode'* directory to user *'testuser'* and archive the *'mycode'* directory
  ```shell
  chown -R testuser:testuser /home/testuser/mycode
  tar -czf app.tar.gz -C mycode .
  md5sum app.tar.gz > appfiles.md5
  ```
- SCP the archive to remote machine with dns *'remote.test.com'*
  ```shell
  scp app.tar.gz appfiles.md5 testuser@remote.test.com:/home/testuser/remotecode
  ```
- Execute the commands in remote server *'remote.test.com'* using ssh
  ```shell
  ssh -T testuser@remote.test.com << EOF
    sudo systemctl stop node
    mv /home/testuser/remotecode/app.* /user/node/data/
    cd /user/node/data/
    tar -xf app.tar.gz
    sudo systemctl start node
  EOF
  ```
- Check the response status code of the endpoint http://remote.test.com/status from local server
  ```shell
  sleep 1s
  status="$(curl --connect-timeout 5 --write-out %{http_code} --silent --output /dev/null http://remote.test.com/status)"
  echo "Status : $status"
  ```
### 4. Shell script to extract log entries with LOG_LEVEL and timestamps

##### Run below command in linux terminal to execute the script
 ```shell
 cd extract_log
 chmod +x extract_log.sh
 sh extract_log.sh
 ```
##### Execution Flow:
- Assign actual values to the variables like LOG_LEVEL, LOGS_DIR, FROM_DATE, TO_DATE.
  ```shell
  FROM_DATE="May 08, 2020 18:00:00 PM"
  TO_DATE="May 09, 2020 08:00:00 AM"
  LOG_LEVEL="SEVERE"
  LOGS_DIR="logs"
  ```
- Create a for loop to get the file names inside the LOGS_DIR and from each file *'grep'* log entries with *'LOG_LEVEL'* and pipe the output to *'awk'* command. Using *'awk'* check the condition to get the log entries in between from and to variables and output to a file test.txt.
  ```shell
  echo > /home/testuser/test.txt
  for file in $(find $LOGS_DIR -type f); do
    grep "$LOG_LEVEL" $file | awk '$0>=from && $0<=to' from="$FROM_DATE" to="$TO_DATE" | awk -v prefix="$file " '{print prefix $0}' >> /home/testuser/test.txt
done
  done
  ```
