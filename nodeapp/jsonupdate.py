#!/usr/bin/python

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
