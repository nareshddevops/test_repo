#!/usr/bin/python

ssn_num = input('Enter your SSN number (123-45-6789):')
ssn_slice = ssn_num.split('-')
if len(ssn_slice) == 3: 
    if len(ssn_slice[0]) == 3 and len(ssn_slice[1]) == 2 and len(ssn_slice[2]) == 4:
        print('Valid SSN number')
    else:
        print('Invalid SSN number format')
else:
   print('Invalid SSN number format')
