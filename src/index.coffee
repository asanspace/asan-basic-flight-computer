Asan = require './asan'
asan = new Asan
Raspicam = require 'raspicam-js'
log4js = require 'log4js'
log4js.loadAppender('file')
log4js.addAppender log4js.appenders.file('logs/asan.log'), 'asan'
logger = log4js.getLogger 'asan'

camera = new Raspicam {
  mode: 'timelapse'
  output: './timelapse/image_%06d.jpg'
  encoding: 'jpg'
  timelapse: 240000
}

camera.start()

setInterval (->
    data = asan.getSensorData()
    console.log {data}
    logger.info(data)
  ), 20000
