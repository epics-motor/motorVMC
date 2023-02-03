#!/usr/bin/env python3

import controller

import os
import sys
import getopt
import asynchat
import asyncore
import socket

DEFAULT_PORT = 31337

class ConnectionDispatcher(asyncore.dispatcher):
	def __init__(self, port):
		asyncore.dispatcher.__init__(self)
		self.port = port
		self.device = controller.Controller()
		self.create_socket(socket.AF_INET, socket.SOCK_STREAM)
		self.set_reuse_addr()
		self.bind(("", port))
		self.listen(5)

	def handle_accept(self):
		# client_info is a tuple with socket as the 1st element
		client_info = self.accept()
		ConnectionHandler(client_info[0], self.device)


class ConnectionHandler(asynchat.async_chat):
	## regular expressions, if necessary, can go here

	def __init__(self, sock, device):
		asynchat.async_chat.__init__(self, sock)
		self.set_terminator(b"\r")
		#
		self.outputTerminator = "\r\n"
		self.device = device
		self.buffer = ""

	def collect_incoming_data(self, data):
		self.buffer = self.buffer + data.decode()

	def found_terminator(self):
		data = self.buffer
		self.buffer = ""
		self.handleClientRequest(data)

	def handleClientRequest(self, request):
		request = request.strip()

		## handle actual commands here

		# Display received commands
		#!print(request)

		# Commands of form
		# X MV 400
		response = self.device.handleCommand(request)

		if response != None:
			self.sendClientResponse("{}".format(response))

		return

	def sendClientResponse(self, response=""):
		data = response + self.outputTerminator
		self.push(data.encode())


def getProgramName(args=None):
	if args == None:
		args = sys.argv
	if len(args) == 0 or args[0] == "-c":
		return "PROGRAM_NAME"
	return os.path.basename(args[0])


def printUsage():
	print("""\
Usage: {} [-ph]

Options:
  -p,--port=NUMBER   Listen on the specified port NUMBER for incoming
                     connections (default: {})
  -h,--help          Print usage message and exit\
""".format(getProgramName(), DEFAULT_PORT))


def parseCommandLineArgs(args):
	(options, extra) = getopt.getopt(args[1:], "p:h", ["port=", "help"])

	port = DEFAULT_PORT

	for eachOptName, eachOptValue in options:
		if eachOptName in ("-p", "--port"):
			port = int(eachOptValue)
		elif eachOptName in ("-h", "--help"):
			printUsage()
			sys.exit(0)

	if len(extra) > 0:
		print("Error: unexpected command-line argument \"{}\"".format(extra[0]))
		printUsage()
		sys.exit(1)

	return port


def main(args):
	port = parseCommandLineArgs(args)
	server = ConnectionDispatcher(port)
	print("Listening on port {}".format(port))
	try:
		asyncore.loop()
	except KeyboardInterrupt:
		print()
		print("Shutting down the server...")
		sys.exit(0)


if __name__ == '__main__':
	# Check the python version
	if sys.version_info < (3,0,0) and sys.version_info < (3,12,0):
		sys.stderr.write("You need Python 3.0 or later (but less than 3.12) to run this script\n")
		input("Press enter to quit... ")
		sys.exit(1)

	# Try to run the server
	try:
		main(sys.argv)
	except Exception as e:
		if isinstance(e, SystemExit):
			raise e
		else:
			print("Error: {}".format(e))
			sys.exit(1)
