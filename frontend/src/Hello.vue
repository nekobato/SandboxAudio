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
const ctx = new (window.AudioContext || window.webkitAudioContext)
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

function playAudioStream(audio_f32) {
    var audio_buf = ctx.createBuffer(1, audio_f32.length, 44100),
      audio_src = ctx.createBufferSource(),
      current_time = ctx.currentTime

    audio_buf.getChannelData(0).set(audio_f32)

    audio_src.buffer = audio_buf
    audio_src.connect(ctx.destination)

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
    console.log(this.$refs)
    ws.binaryType = 'arraybuffer';
    ws.onopen = () => {
      ws.send('something')
    }

    ws.onmessage = (event) => {
      console.log(event.data)
      if (event.data instanceof ArrayBuffer) {
        this.$refs.audio.srcObject = event.data
        // playAudioStream(new Float32Array(event.data));
      }
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
