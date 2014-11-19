
config = require('./config')

module.exports = class Socket

  socket = null

  constructor: () ->

    socket = io()

    socket.on 'sdp', (data) ->
      peer.onCatchSdp JSON.parse(data)

    socket.on 'candidate', (data) ->
      candidate = new RTCIceCandidate JSON.parse(data)

    socket.on 'user status', (data) ->
      console.log "user:", data
      app.userlist.push {id: data}

    socket.on 'entered', (data) ->
      console.log data
      app.my.id = data.id

    socket.on 'user entered', (data) ->
      console.log 'user entered', data
      app.userlist.push data

    socket.on 'user leaved', (data) ->
      console.log 'user leaved', data
      app.userlist.forEach (v, i) ->
        app.userlist.splice(i, 1) if v.id is data

    socket.on 'disconnect', (data) ->
      #socket.emit 'disconnected', app.my_id

    return @


  emit: (event, data) ->
    socket.json.emit event, data
