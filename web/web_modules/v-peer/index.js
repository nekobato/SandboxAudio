import Peer from 'peerjs';

let peer = null;

export default function() {
  let connectPeer = new ConnectPeer();

}


class ConnectPeer {

  constructor() {

    let peer = new Peer({
      iceServers: [{ url: "stun:stun.l.google.com:19302" }],
      host: 'nekobato-peer.herokuapp.com',
      port: 80,
      path: '/'
    });

    // Receive
    peer.on('open', function(id) {

      console.debug('My peer ID is: ' + id);

      peer.on('connection', function(conn) {
        conn.on('open', function() {
          console.log('peer opened');

          // Receive messages
          conn.on('data', function(data) {
            console.log('Received', data);
          });
        });
      });
    });
  }

  // Connect
  connect(peer_id) {

    if (typeof peer_id === "undefined") {
      throw new Error('connect(peer_id) needs peer_id');
    }

    // connect
    let conn = peer.connect(peer_id);
    console.debug(`connecting... ${peer_id}`);

    conn.on('open', function() {
      console.log('peer opened');

      // Receive messages
      conn.on('data', function(data) {
        console.log('Received', data);
      });

      // Send messages
      conn.send('Hello!');
    });
  }
}
