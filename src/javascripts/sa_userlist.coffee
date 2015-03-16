module.exports =
  template: "#sa_userlist"

  data:
    hoge: []

  methods:

    onUserlistReceived: (data) ->
      console.log data

    onPeeridReceived: (data) ->
      socket.emit 'join join', data


  created: () ->

    @$on 'peerid received',   @onPeeridReceived
    @$on 'userlist received', @onUserlistReceived
