
peer = new Peer
  iceServers: [{ url: "stun:stun.l.google.com:19302" }]
  host: 'sa-peerjs.herokuapp.com',
  port: 80
  path: '/'


peer.on 'open', (id) =>
  console.log('My peer ID is: ' + id)

  SA.$dispatch 'peerid received', { peerid: id }


peer.on 'connection', (dataConnection) =>

  dataConnection.on 'open', () =>

    console.log 'dataconnetion opened'
    dataConnection.send('Hello!')

    dataConnection.on 'data', (data) =>
      console.log 'Data received: ', data
      # @audioStream = data
      # @$emit 'audio received'

  dataConnection.on 'close', () ->
    console.log 'data connection closed'


module.exports = peer
