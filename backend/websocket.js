const WebSocket = require('ws')

module.exports = function (server) {

  const wss = new WebSocket.Server({ server })

  const types = {
    ENTER: 'ENTER',
    GET_USERS: 'GET_USERS',
    ADD_AUDIO: 'ADD_AUDIO',
    AUDIO_STREAM: 'AUDIO_STREAM'
  }

  users = []
  audios = []

  wss.on('connection', function connection(ws) {

    ws.on('message', onMessage)

    ws.on(types.ENTER, function (peerId) {
      users.push(peerId)
      broadcast({ type: 'USERS', payload: users })
    })

    ws.on(types.GET_USERS, function (message) {
      ws.send({ type: 'USERS', payload: users })
    })

    ws.on(types.ADD_AUDIO, function (audio) {
      audios.push(JSON.parse(audio))
      broadcast({ type: 'AUDIOS', payload: audios })
    })

    ws.on(types.AUDIO_STREAM, function (audio) {
      console.log(audio)
    })
  })

  function broadcast (data) {
    wss.clients.forEach(function each(client) {
      if (client.readyState === WebSocket.OPEN) {
        client.send(data)
      }
    })
  }

  function onMessage (message) {
    console.log(message)
    if (typeof message === 'string') {
      console.log(message)
    } else {
      broadcast(message)
    }
  }
}
