config = require('./config')

window.SA = new Vue
  el: "#sa"
  data:
    my:
      id: 'null'
    peer: null
    ws: null
    users: []
  methods:
    connect: (id) ->
      conn = @peer.connect(id)

      conn.on 'open', () ->

        conn.on 'data', (data) ->
          console.log('Received', data)

        conn.send('Hello!')

    getUserAll: () ->
      @socket.emit 'get user all'

  created: () ->

    @socket = io('localhost:3000/')

    @socket.on 'connect', () =>
      console.log 'Socket:', 'connected'

      @socket.on 'users', (data) =>
        @users = Object.keys(data).map (v) -> { id: data[v] }

      @peer = new Peer
        host: 'sa-peerjs.herokuapp.com',
        port: 80
        path: '/'

      @peer.on 'open', (id) =>
        console.log('My peer ID is: ' + id)
        @my.id = id
        @socket.emit 'create user', { id: id }
