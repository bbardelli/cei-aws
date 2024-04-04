#!/bin/bash
sudo yum update -y
sudo yum install python3 -y
sudo yum install python3-pip -y
sudo pip3 install cherrypy
# Create a Python file
cat > hello_world.py <<EOF
import cherrypy
import os

class HelloWorld:
    @cherrypy.expose
    def index(self):
        ret = f'Hello World! from {os.uname().nodename}'
        ret += f'<br> Your IP is (Remote-Addr): {cherrypy.request.headers["Remote-Addr"]}'
        ret += f'<br> Your IP is (X-Forwarded-For): {cherrypy.request.headers.get("X-Forwarded-For", "N/A")}'
        ret += f'<br> Your User-Agent is: {cherrypy.request.headers["User-Agent"]}'
        ret += f'<br> Your Host is: {cherrypy.request.headers["Host"]}'
        return ret

if __name__ == '__main__':
    cherrypy.config.update({'server.socket_port': 80, 'server.socket_host': '0.0.0.0',})
    cherrypy.quickstart(HelloWorld())
EOF
# Run the server (may need sudo to bind to port 80)
sudo python3 hello_world.py