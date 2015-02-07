
config = require('./config')
peer = require('./peer')

socket = io()

socket.on 'webrtc sdp', (data) ->
  #sdp = new RTCSessionDescription(data.sdp)
  #peer.setRemoteDescription sdp, () ->
    # final answer if sdp.type is "offer"

socket.on 'candidate', (data) ->
  #candidate = new RTCIceCandidate data.candidate
  #peer.addIceCandidate(candidate)

socket.on 'user status', (data) ->
  console.log "user:", data
  app.userlist.push {id: data}

socket.on 'entered', (data) ->
  console.log data
  app.my.id = data.id

socket.on 'user entered', (data) ->
  console.log 'user entered', data
  app.userlist.push data
  peer.createOffer(data.id)

socket.on 'user leaved', (data) ->
  console.log 'user leaved', data
  app.userlist.forEach (v, i) ->
    app.userlist.splice(i, 1) if v.id is data

socket.on 'disconnect', (data) ->
  #socket.emit 'disconnected', app.my_id

module.exports =

  emit: (event, data) ->
    socket.json.emit event, data
