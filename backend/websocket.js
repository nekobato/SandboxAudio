const WebSocket = require('ws')
const fs = require('fs')
const pcm = require('pcm')

bufferSize = 8192

module.exports = function (server) {

  const wss = new WebSocket.Server({ server })

  users = []
  audios = []

  var buffer = new Float32Array(bufferSize)
  var bufferIndex = 0

  wss.on('connection', function connection(ws) {

    ws.on('message', onMessage)

    pcm.getPcmData('test.mp3', { stereo: false, sampleRate: 44100 }, (sample, channel) => {
      buffer[bufferIndex++] = sample
      if (bufferIndex == buffer.length) {
        ws.send(buffer)
        buffer = new Float32Array(bufferSize)
        bufferIndex = 0
      }
    }, (err, output) => {
      if (err) {
        ws.close()
      }
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
