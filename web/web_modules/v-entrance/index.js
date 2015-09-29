function dataSet() {
  return {
    avatar: {
      name: null,
      peer_id: null,
    }
  }
}

export default ({
  template: require('./template.jade')(),
  data: dataSet,
  event: {
    'peer_id:received': function(peer_id) {
      this.set('avatar.peer_id', peer_id);
    }
  },
  ready: function() {
  }
});
