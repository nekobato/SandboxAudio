function dataSet() {
  return [
    {
      avatar: {
        name: "",
        id: "",
        peer_id: "",
      }
    }
  ]
}

export default ({
  template: require('./template.jade')(),
  data: require('./data.debug.json'),
  event: {
    'peer_id:received': function(peer_id) {
      this.set('avatar.peer_id', peer_id);
    }
  },
  ready: function() {
  }
});
