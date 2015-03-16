app = require('express')()
server = require('http').Server(app)
redis = require("redis").createClient()

io = require('socket.io')(server)

io.on 'connection', (socket) ->

  socket.user = { id: null } if !socket.user

  # socket.on 'enter', () ->

    #socket.peer.id = (Math.random().toString(36) + '0000000000000000000').substr(2, 16)

    # LPUSH [room]_users [userid], LREM [room]_users -1 [userid] で管理した方がよさげ
    # room propatiesは[room]で管理する

  socket.on 'join join', (data) ->

    # data implements
    # peerid
    # name
    console.log data

    # set data into memory
    socket.user = data
    # room userlist
    redis.lpush 'main_useridlist', data.peerid
    , (err, res) -> # nothing to do
    # user profile
    redis.hset "user_#{data.userid}",
      name: data.name || ""
      userid: data.peerid
    , (err, res) -> # nothing to do
    # broadcast to room users
    socket.broadcast.emit 'here comes a new user'

  socket.on 'get userid all', (data) ->
    redis.hgetall 'main_useridlist', (err, res) ->
      console.log "useridlist: ", res
      socket.emit 'userlist', res


  socket.on 'disconnect', () ->

    redis.hdel "users", "user_#{socket.user.id}" if socket.user

    socket.broadcast.emit 'user leaved', socket.user.id if socket.user.id

module.exports = io
