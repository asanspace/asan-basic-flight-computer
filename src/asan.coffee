five   = require 'johnny-five'

class Asan
  constructor: () ->
    @sensorData =
      uv: 0
      temp: 0
      gas: 0
      gps: []

    board = new five.Board()

    board.on 'ready', () =>
      temp = new five.Sensor "A3"
      uv = new five.Sensor "A2"
      gas = new five.Sensor "A0"
      gps = new five.GPS([6, 5])

      temp.on 'change', @handleTemp
      uv.on 'change', @handleUv
      gas.on 'change', @handleGas
      gps.on 'data', @handleGps


  handleGps: (data) =>
    { latitude, longitude, altitude, speed, time } = data
    time = parseFloat time
    gpsData = "[#{latitude},#{longitude},#{altitude},#{speed},#{time}]"
    @sensorData.gps = gpsData

  handleTemp: (data) =>
    @sensorData.temp = data

  handleUv: (data) =>
    @sensorData.uv = data

  handleGas: (data) =>
    @sensorData.gas = data

  getSensorData: () =>
    @sensorData

module.exports = Asan
