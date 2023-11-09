from twisted.protocols.ftp import FTPFactory, FTPRealm
from twisted.cred.portal import Portal
from twisted.cred.checkers import InMemoryUsernamePasswordDatabaseDontUse
from twisted.internet import reactor

# Create your username and password.
checkers = [InMemoryUsernamePasswordDatabaseDontUse(relay='Sadri@123')]

# Create a portal and register checkers with it.
p = Portal(FTPRealm('./'), checkers)

# Create an FTP factory and register the portal with it.
factory = FTPFactory(p)

# Start the FTP server on localhost at port 2121.
reactor.listenTCP(2121, factory)
reactor.run()
