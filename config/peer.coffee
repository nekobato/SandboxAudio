express = require('express')
path = require('path')
app = express()

ExpressPeerServer = require('peer').ExpressPeerServer

options =
  debug: true

app.use('/api', ExpressPeerServer(server, options));

// OR

server = require('http').createServer(app);

app.use('/peerjs', ExpressPeerServer(server, options));

server.listen(9000);
