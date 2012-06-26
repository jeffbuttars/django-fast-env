###############################################
# Gunicorn configuration file.
# http://gunicorn.org/configure.html
###############################################

import multiprocessing

bind = "127.0.0.1:8000"

# This may not working with python older than 2.6
workers = multiprocessing.cpu_count() * 2 + 1

# use gevent for async, default is sync
worker_class = 'gevent' 

# Maximum number of pending connections
backlog = 2048

# maximum number of simoultaneious clients
worker_connections = 1000 

# The maximum number of requests each worker will process 
# before being restarted. If set to 0, there is never a 
# worker restart. This can be helpfull keeping memory leaks
# as well as helping refresh db connectoins.
max_requests = 4096

# With sync, the max life of a connection
# With async, the max idle time of a connection
# if exceeded, the connection is terminated
timeout = 30

keepalive = 2

debug = False

# Spew every line executed by the server.
# AKA: nuclear option
spew = False

daemon = False

# Filename to write the pid file to
pidfile = None

# switch the process to use this user
#user = 'wipipecentral'

# switch the process to use this group 
#group = 'wipipecentral'

# umask used to write files
umask = 0

tmp_upload_dir = None

# The filename of the access log to write to
accesslog = None

# h: remote address t: date of the request r: 
# status line (ex: GET / HTTP/1.1) s: status b: response length or '-' 
# f: referer a: user agent T: request time in seconds D: request time in microseconds
# You can also pass any WSGI request header as a parameter. (ex '%(HTTP_HOST)s'
access_log_format = '%(h)s %(l)s %(u)s %(t)s "%(r)s" %(s)s %(b)s "%(f)s" "%(a)s"'

# Error log filename
# default, -, is stdout
error_log = '-'

# debug
# info
# warning
# error
# critical
loglevel = 'info'

# You can provide your own log handler here, if you wish
logger_class = 'simple'

# Requires the setproctitle module
#proc_name = None
proc_name = 'wpc_gunicorn' 

# Don't worry about this
#default_proc_name = 'gunicorn'

# Hooks:

# called just before the master process is initialized
#def on_starting(server):
#	"""docstring for on_starting"""
#	pass
##on_starting()

# Called to recycle workers during a reload via SIGHUP
#def on_reload(server):
#	"""docstring for on_reload"""
#	for i in range(server.app.cfg.workers):
#		server.spawn_worker()
##on_reload()

# Called just after the server is started
#def start_server(server):
#	"""docstring for start_server"""
#	pass
##start_server()

# Called just before a worker is forked
#def pre_fork(server, worker):
#	"""docstring for pre_fork"""
#	pass
##pre_fork()

# Called just after a worker is forked
#def post_fork(server, worker):
#	"""docstring for post_fork"""
#	pass
##post_fork()

# called just before a new master process is forked
#def pre_exec(server):
#	"""docstring for pre_exec"""
#	pass
##pre_exec()

# called just before a worker processess the request
#def pre_request(worker, req, environ):
#	"""docstring for pre_request"""
#	pass
##pre_request()


# called just after a worker processess the request
#def post_request(worker, req, environ):
#	"""docstring for post_request"""
#	pass
##post_request()

# called just after a worker has been exited
#def worker_exit(server, worker):
#	"""docstring for worker_exit"""
#	pass
##worker_exit()

