let PeerCon = require('components/connect-peer');

module.exports = {
  el: "#sunaba_audio",
  data: {
    test: true,
    test2: false,
  },
  components: {
  },
  ready: function() {
    this.peercon = new PeerCon;
  }
}
