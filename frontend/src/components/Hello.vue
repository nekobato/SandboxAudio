<template>
  <div class="hello">
    <h1>Sunaba Audio</h1>
    <h2>Get Peer Id</h2>
    <p>Your Peer Id: <strong>{{ peerId }}</strong></p>
    <div>
      <input type="text" v-model="anotherPeerId">
      <button @click="peerConnect">Connect</button>
    </div>
    <div>
      <input type="file" @change="onChangeFileInput">
      <button @click="sendAudio">SendAudio</button>
    </div>
    <div>
      <audio controls ref="audio"></audio>
    </div>
  </div>
</template>

<script>
var ws

export default {
  name: 'hello',
  data () {
    return {
      msg: 'Welcome to Your Vue.js App',
      peerId: '',
      anotherPeerId: '',
      audioFile: null
    }
  },
  methods: {
    sendAudio () {
      ws.send(this.$data.audioFile)
    },
    onChangeFileInput (e) {
      this.$data.audioFile = e.target.files[0]
    }
  },
  mounted () {
    ws = new WebSocket('ws://127.0.0.1:3000')
    ws.binaryType = 'arraybuffer';
    ws.onopen = function () {
      console.log('open')
      ws.send('something')
    }

    ws.onmessage = function (data) {
      console.log(data)
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}

ul {
  list-style-type: none;
  padding: 0;
}

li {
  display: inline-block;
  margin: 0 10px;
}

a {
  color: #42b983;
}
</style>
