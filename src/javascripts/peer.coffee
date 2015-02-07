
config = require('./config')
socket = require('./socket')

peer = new webkitRTCPeerConnection {"iceServers": config.stn_servers}

peer.onicecandidate = (e) ->
  return if !e.candidate

  socket.emit 'candidate',
    "candidate": e.candidate
    "type": 'candidate'

console.log socket
console.log config
module.exports =

  createOffer: (to_id) ->
    peer.createOffer (sdp) ->
      peer.setLocalDescription sdp, () ->
        socket.emit 'offer',
          "sdp": sdp
          "to":  to_id

  createAnswer: (from_id, sdp) ->
    peer.createAnswer (sdp) ->
      peer.setLocalDescription sdp, () ->
        socket.emit 'answer',
          "sdp": sdp
          "to":  from_id

  onAnswered: (sdp) ->
    sdp = new RTCSessionDescription(sdp)

    peer.setRemoteDescription sdp, () ->

  onIceCandidate: (candidate) ->
    candidate = new RTCIceCandidate(candidate)
    peer.addIceCandidate(candidate)
