import cherrypy

class MyAPI:
    @cherrypy.expose
    @cherrypy.tools.json_in()
    def index(self):
        if cherrypy.request.method == 'POST':
            data = cherrypy.request.json
            # Process the POST request data here
            return 'POST request received'
        else:
            return 'Hello, world!'

if __name__ == '__main__':
    cherrypy.config.update({'server.socket_host': '0.0.0.0', 'server.socket_port': 8080})
    cherrypy.quickstart(MyAPI())