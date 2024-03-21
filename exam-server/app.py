import cherrypy
import os
import json
import fromfile
import fromsss
import fromdynamo

database_type = os.environ.get('DATABASE_TYPE', 'file')
if database_type == 'file':
    ff = fromfile
    print("Using file")
elif database_type == 's3':
    ff = fromsss
    print("Using s3")
elif database_type == 'dynamo':
    ff = fromdynamo
    print("Using dynamo")


cherrypy.config.update({'server.socket_port': 80})
cherrypy.config.update({'server.socket_host':'0.0.0.0'})
conf = { '/':
  { 'tools.staticdir.on' : True,
    'tools.staticdir.dir' : f'{os.path.abspath(os.path.dirname(__file__))}/static/',
    'tools.staticdir.index' : 'index.html' } }

class App:

    @cherrypy.expose
    @cherrypy.tools.json_out()
    def get_exam_from_file(self,filename="exam20.md"):
        #read get param from url
        return ff.get_exam(filename)
    
    @cherrypy.expose
    @cherrypy.tools.json_out()
    def exams(self):
        #read get param from url
        #return all the file names in the exams folder
        return ff.get_exam_list()
    
cherrypy.quickstart(App(), '/', conf)