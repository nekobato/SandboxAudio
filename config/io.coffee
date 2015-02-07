app = require('express')()
server = require('http').Server(app)
redis = require("redis").createClient()

io = require('socket.io')(server)

io.on 'connection', (socket) ->

  socket.user = { id: null } if !socket.user

  socket.on 'enter', () ->

    #socket.peer.id = (Math.random().toString(36) + '0000000000000000000').substr(2, 16)



  socket.on 'create user', (data) ->

    socket.user = data

    socket.broadcast.emit 'user joined: ', socket.peer

    redis.hset "users", "user_#{data.id}", "#{data.id}"

  socket.on 'get user all', (data) ->
    redis.hgetall 'users', (err, res) ->
      console.log "users: ", res
      socket.emit 'users', res


  socket.on 'disconnect', () ->

    redis.hdel "users", "user_#{socket.user.id}" if socket.user

    socket.broadcast.emit 'user leaved', socket.user.id if socket.user.id

module.exports = io
