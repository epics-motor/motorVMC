#!/usr/bin/env python3

import controller

import asyncio
import os
import sys
import getopt

DEFAULT_PORT = 31337
OUTPUT_TERMINATOR = "\r\n"


async def handle_connection(reader, writer, device):
	addr = writer.get_extra_info("peername")
	try:
		while True:
			# Read until \r terminator
			try:
				data = await reader.readuntil(b"\r")
			except asyncio.IncompleteReadError:
				# Client disconnected mid-message
				break
			except ConnectionResetError:
				break

			request = data.decode().strip()
			if not request:
				continue

			# Dispatch command to the controller
			response = device.handleCommand(request)

			if response is not None:
				output = "{}{}".format(response, OUTPUT_TERMINATOR)
				writer.write(output.encode())
				await writer.drain()
	except asyncio.CancelledError:
		pass
	finally:
		writer.close()
		try:
			await writer.wait_closed()
		except Exception:
			pass


async def run_server(port):
	device = controller.Controller()

	# Use a closure to pass the shared device to each connection handler
	async def client_handler(reader, writer):
		await handle_connection(reader, writer, device)

	server = await asyncio.start_server(client_handler, "", port)
	print("Listening on port {}".format(port))

	try:
		async with server:
			await server.serve_forever()
	except asyncio.CancelledError:
		pass


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
	try:
		asyncio.run(run_server(port))
	except KeyboardInterrupt:
		print()
		print("Shutting down the server...")
		sys.exit(0)


if __name__ == '__main__':
	# Check the python version
	if sys.version_info < (3, 7, 0):
		sys.stderr.write("You need Python 3.7 or later to run this script\n")
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
