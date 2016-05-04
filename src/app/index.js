module.exports = {
  el: 'body',
  template: require('./template')
  data: function() {
    return {
      styles: require('./style')
    }
  }
}
