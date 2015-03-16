socket = io('localhost:3000/')

socket.on 'connect', () ->
  SA.$dispatch 'socket connected'

socket.on 'userlist', (data) =>
  console.log data
  # emit -> userlist component

module.exports = socket
