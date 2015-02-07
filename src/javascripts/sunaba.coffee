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
      conn = peer.connect(id)

      conn.on 'open', () ->

        conn.on 'data', (data) ->
          console.log('Received', data)

        conn.send('Hello!')

  created: () ->

    @peer = new Peer
      host: 'sa-peerjs.herokuapp.com',
      port: 80
      path: '/'

    @peer.on 'open', (id) =>
      console.log('My peer ID is: ' + id)
      @my.id = id
