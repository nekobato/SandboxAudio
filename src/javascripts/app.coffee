config = require('./config')
Socket = require('./socket')
#peer = require('./peer').create()

socket = new Socket()

window.app = new Vue
  el: "#sunaba"
  data:
    my: {}
    room: config.room
    playlist: [
      { name: 'title name' }
    ]
    userlist: []

  methods:
    drop: (event) ->
      event.preventDefault()
      console.log 'dropped'
      files = event.dataTransfer.files
      console.log files

      @playlist.push
        name: files[0].name
        file: files[0]

      reader = new FileReader()
      reader.onloadend = ->
        console.log reader.result
        #document.getElementById('audio').src = reader.result
      reader.readAsDataURL( files[0] )

    dragOver: (event) ->
      event.preventDefault()
    dragLeave: (event) ->
      event.preventDefault()

  created: () ->

    socket.emit 'enter',
      room: @room
