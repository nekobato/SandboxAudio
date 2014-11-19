
config = require('./config')

module.exports = class Peer

  peer = null
  app = null

  constructor: (_app) ->

    peer = new webkitRTCPeerConnection {"iceServers": config.stn_servers}
    app = _app

    peer.onicecandidate = (e) ->
      return if !e.candidate

      app.socket.emit 'candidate',
        "candidate": e.candidate,
        "type":      'candidate'

    return @

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
