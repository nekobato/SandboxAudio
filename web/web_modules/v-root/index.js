import PeerCon from 'v-peer';

export default ({
  el: "#sunaba_audio",
  template: require('./template.jade')(),
  data: {
    test: true,
    test2: false,
  },
  ready: function() {
    this.peercon = new PeerCon;
  }
});
