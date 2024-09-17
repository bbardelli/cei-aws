import cherrypy

class HelloWorld:
    @cherrypy.expose
    def index(self):
        return "Hello World!"

if __name__ == '__main__':
    cherrypy.config.update({'server.socket_port': 80, 'server.socket_host': '0.0.0.0',})
    cherrypy.quickstart(HelloWorld())