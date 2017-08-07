const Peer = require('peerjs')

const peer = new Peer({
  iceServers: [{ url: "stun:stun.l.google.com:19302" }],
  host: 'nekobato-peer.herokuapp.com',
  port: 80,
  path: '/'
})
.on('open', (id) => {
  console.debug(`My peer ID is: ${id}`)
})

window.connectPeer = function () {
  console.debug('connect start')
  peer_id = document.querySelector('#peer_id').value
  console.debug(`peerid: ${peer_id}`)
  conn = peer.connect(peer_id)

  console.debug(conn)

  conn.on('open', () => {
    console.debug('connection opened')
    conn.on('data', (data) => {
      imageEl.src = data
    })
    conn.send(canvas.toDataURL('image/jpeg'))
  })
}
