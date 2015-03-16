config  = require('./config')
socket  = require('./socket')
psocket = require('./psocket')

window.SA = new Vue

  el: "#sandbox"

  components:
    userlist: require('./sa_userlist')
    playlist: require('./sa_playlist')
    jukebox:  require('./sa_jukebox')
    chatform: require('./sa_cheerform')

  data:
    my:
      id: 'null'
    peer: null
    ws: null
    users: []
    audioStream: null
    target_peer_id: null
    audio: new Audio()

  methods:
    connectPeer: (e) ->
      console.log 'connect try'

      dataConnection = @peer.connect(e.target.innerText)
      @target_peer_id = e.target.innerText

      dataConnection.on 'open', () =>
        console.log 'dataconnection opened'
        console.log 'send: ', @audioStream
        dataConnection.send @audioStream

      .on 'data', (data) ->
        console.log 'Data received: ', data

      .on 'error', () ->
        console.log 'dataconnection errored'

    getUserAll: (e) ->
      @socket.emit 'get user all'

    setAudio: (e) ->
      @audioStream = URL.createObjectURL e.target.files[0]
      console.log @audioStream

    onAudioReceived: () ->
      console.log 'audio event receieved'
      @audio.src = @audioStream
      @audio.play()


    # peer.callはmediaStreamしか送れないのでx
    # connectによりdataConnectionを得た後、dataConnection.send(data)によって送るのがよいかも


  created: () ->

    @$on 'audio received', @onAudioReceived
