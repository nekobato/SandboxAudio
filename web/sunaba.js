import Vue from 'vue';

window.onload = function() {

  Vue.component('v-entrance', require('v-entrance'));

  let master = new Vue(require('v-root'));

}
