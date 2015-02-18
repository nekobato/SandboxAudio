config = require('./config')

window.SA = new Vue

  el: "#sa"

  data:
    my:
      id: 'null'
    peer: null
    ws: null
    users: []
    audioStream: null
    target_peer_id: null

  methods:
    connectPeer: (e) ->
      console.log 'connect try'

      dataConnection = @peer.connect(e.target.innerText)
      @target_peer_id = e.target.innerText

      dataConnection.on 'open', () =>
        console.log 'dataconnection opened'
        #dataConnection.send('Hello! peer')
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

    # 方向性としては、callはmediaStreamしか送れないのでx
    # connectによりdataConnectionを得た後、dataConnection.send(data)によって送るのがよいかも


  created: () ->

    @socket = io('localhost:3000/')

    @socket.on 'connect', () =>
      console.log 'Socket:', 'connected'

      @socket.on 'users', (data) =>
        @users = Object.keys(data).map (v) -> { id: data[v] }

      @peer = new Peer
        iceServers: [{ url: "stun:stun.l.google.com:19302" }]
        host: 'sa-peerjs.herokuapp.com',
        port: 80
        path: '/'

      @peer.on 'open', (id) =>
        console.log('My peer ID is: ' + id)
        @my.id = id
        @socket.emit 'create user', { id: id }

      @peer.on 'connection', (dataConnection) ->

        dataConnection.on 'open', () ->

          console.log 'dataconnetion opened'
          dataConnection.send('Hello!')

          dataConnection.on 'data', (data) ->
            console.log 'Data received: ', data
            SA.audioStream = data

        dataConnection.on 'close', () ->
          console.log 'data connection closed'
