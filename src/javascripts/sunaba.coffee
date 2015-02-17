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

      @peer.connect(e.target.innerText)
      @target_peer_id = e.target.innerText

    getUserAll: (e) ->
      @socket.emit 'get user all'

    createStream: (e) ->
      console.log e

    # 方向性としては、callはmediaStreamしか遅れないのでx
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

      @peer.on 'call', (mediaConnection) ->
        console.log mediaConnection.peer

      @peer.on 'connection', (conn) ->
        console.log 'peer connected'
        conn.send 'Hello!'

        conn.on 'data', (data)->
          console.log data

      @peer.on 'call', (call) ->
        call.on 'stream', (stream) ->
          @audioStream = URL.createObjectURL stream
