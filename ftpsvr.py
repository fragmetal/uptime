from twisted.protocols.ftp import FTPFactory, FTPRealm
from twisted.cred.portal import Portal
from twisted.cred.checkers import InMemoryUsernamePasswordDatabaseDontUse
from twisted.internet import reactor
from pyngrok import ngrok

# Set your authtoken from your ngrok account
ngrok.set_auth_token("26eB9yvckCFT8fpaZMsXfRnES3c_59yZgjPQPH4Dt6G3MXmGN")

tunnel = ngrok.connect(2121, "tcp")
print("Public Access:", tunnel.public_url)

# Create your username and password.
checkers = [InMemoryUsernamePasswordDatabaseDontUse(relay='Sadri@123')]

# Create a portal and register checkers with it.
p = Portal(FTPRealm('./'), checkers)

# Create an FTP factory and register the portal with it.
factory = FTPFactory(p)

# Start the FTP server on localhost at port 2121.
reactor.listenTCP(2121, factory)
reactor.run()
