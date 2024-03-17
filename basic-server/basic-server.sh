#!/bin/bash
sudo yum update -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo pip3 install cherrypy
# Create a Python file
cat > hello_world.py <<EOF
import cherrypy

class HelloWorld:
    @cherrypy.expose
    def index(self):
        return "Hello World!"

if __name__ == '__main__':
    cherrypy.config.update({'server.socket_port': 80, 'server.socket_host': '0.0.0.0',})
    cherrypy.quickstart(HelloWorld())
EOF
# Run the server (may need sudo to bind to port 80)
sudo python3 hello_world.py

