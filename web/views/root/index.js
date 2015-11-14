// import PeerCon from 'peer';

export default ({
  el: "#sunaba_audio",
  template: require('./template.jade')(),
  data: {
    test: true,
    test2: false,
  },
  methods: {
    onDragStart: function() {
      console.log('dragstart');
    }
  },
  ready: function() {
    // this.peercon = new PeerCon;
  }
});
