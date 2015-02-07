config = require('./config')
socket = require('./socket')
peer = require('./peer')
console.log peer
window.AudioContext = window.AudioContext || window.webkitAudioContext

window.app = new Vue
  el: "#sunaba"
  data:
    my: {
      name: 'myname'
      id: 'myid'
    }
    room: config.room
    playlist: [
      { name: 'title name' }
    ]
    userlist: []

  methods:
    drop: (event) ->
      event.preventDefault()
      files = event.dataTransfer.files
      console.log files

      @playlist.push
        name: files[0].name
        file: files[0]

      reader = new FileReader()
      reader.onprogress = (event) ->
        if event.lengthComputable && event.total > 0
          rate = Math.floor((event.loaded / event.total) * 100)
          document.getElementById('dropzone-progress').style.width = rate + '%'
      reader.onload = ->
        context = new AudioContext()
        context.decodeAudioData reader.result, (audioBuffer) ->
          source = context.createBufferSource()
          source.buffer = audioBuffer
          source.connect(context.destination)
          source.start()

      reader.readAsArrayBuffer( files[0] )

    dragOver: (event) ->
      event.preventDefault()
    dragLeave: (event) ->
      event.preventDefault()


  created: () ->

    socket.emit 'enter',
      room: @room
