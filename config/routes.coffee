express = require('express')
mongoose = require('mongoose')
path = require('path')
app = express()
router = express.Router()

router.get "/", (req, res, next) ->
  dataModel = require path.resolve 'models/dataModel'
  res.render "index",
    title: "SunabaAudio"
  return

router.get "/ch/:room", (req, res, next) ->
  res.render "audioroom",
    title: "SunabaAudio"
    room: {name: req.param('room')}

router.get "/help", (req, res, next) ->
router.get "/explore", (req, res, next) ->


module.exports = router
