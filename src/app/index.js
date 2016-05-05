// import styles from './style';

module.exports = {
  el: 'body',
  template: require('./template')(),
  replace: false,
  components: {
    avators: require('components/avators')
  },
  data: {
    // styles: styles
  }
}
