# Zebra client by Carl Tashian, yerdle.
#
# To run in debug mode and output labels to a file instead of a printer,
#  $ coffee zebra.js.coffee debug

dotenv = require('dotenv')
dotenv.load()

jst = require('jst')
PusherClient = require('pusher-node-client').PusherClient
child_process = require('child_process')
fs = require('fs')

DEBUG = (process.argv[2] == 'debug')
console.log "Running in debug mode" if DEBUG

pusher_client = new PusherClient
  appId: process.env.PUSHER_APP_ID
  key: process.env.PUSHER_KEY
  secret: process.env.PUSHER_SECRET

pres = null
pusher_client.on 'connect', () ->
  pres = pusher_client.subscribe("items")

  # data will look like:
  # { id: 12312312,
  #   title: 'kinesis keyboard' }

  pres.on 'new', (data) ->
    if DEBUG
      lpr = child_process.spawn "bash", ['-c', "cat > test.zpl"]
    else
      lpr = child_process.spawn "lpr", ['-P', process.env.ZEBRA_PRINT_QUEUE_NAME, '-o', 'raw']

    jst.renderFile('item-template.zpl', data, (err, zpl) ->
      if err
        console.log "There was an error printing: #{err}"
      else
        lpr.stdin.write(zpl)
        lpr.stdin.end()
    )

    lpr.on 'close', (code) ->
      console.log "Child process exit with code #{code}" if DEBUG


pusher_client.connect()
