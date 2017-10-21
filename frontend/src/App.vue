<template>
  <div class="hello">
    <h1>Sunaba Audio</h1>
    <div>
      <input type="text" v-model="anotherPeerId">
      <button>Connect</button>
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
const audioCtx = new (window.AudioContext || window.webkitAudioContext)
const ws = new WebSocket('ws://127.0.0.1:3000')
var initial_delay_sec = 0;
var scheduled_time = 0;

function playChunk(audio_src, scheduled_time) {
    if (audio_src.start) {
        audio_src.start(scheduled_time)
    } else {
        audio_src.noteOn(scheduled_time)
    }
}

function playAudioStream(f32Buffer) {
    var audio_buf = audioCtx.createBuffer(1, f32Buffer.length, 44100)
    var audio_src = audioCtx.createBufferSource()
    var current_time = audioCtx.currentTime

    audio_buf.getChannelData(0).set(f32Buffer)

    audio_src.buffer = audio_buf
    audio_src.connect(audioCtx.destination)

    if (current_time < scheduled_time) {
        playChunk(audio_src, scheduled_time)
        scheduled_time += audio_buf.duration
    } else {
        playChunk(audio_src, current_time)
        scheduled_time = current_time + audio_buf.duration + initial_delay_sec
    }
}

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
      var buffer = new Float64Array(65536)

      ws.send(this.$data.audioFile)
    },
    onChangeFileInput (e) {
      this.$data.audioFile = e.target.files[0]
    }
  },
  mounted () {
    var startTime = 0

    ws.binaryType = 'arraybuffer'

    ws.onopen = () => {
      ws.send('something')
    }

    ws.onmessage = (event) => {
      playAudioStream(new Float32Array(event.data))
    }
  }
}
</script>

<style lang="scss">
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

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
