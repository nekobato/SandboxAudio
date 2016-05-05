// import styles from './style';

module.exports = {
  template: require('./template')(),
  data: function() {
    return {
      // styles: styles
      avatars: [
        // Avators Schema
        {
          id: "avatar_id",
          name: "Avatar Name"
        }
      ]
    }
  }
}
