#!/usr/bin/python

#mystr = 'abcdef'
mystr = input('Enter the string: ')
counter = len(mystr) - 1
new_str = ''
while counter >= 0:
    new_str += mystr[counter]
    counter -= 1
print(new_str)
