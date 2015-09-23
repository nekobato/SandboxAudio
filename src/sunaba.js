import Vue from 'vue';

window.onload = () => {

  window.options = [];
  window.options.debug = true;

  let master = new Vue(require('components/master'));

  // debug mode
  if ( window.options.debug === true ) {
    console.debug('### debug mode ###');
    window.master = master
  }
}
