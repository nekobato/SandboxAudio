import PeerCon from 'v-peer';

export default ({
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
});
