Socket = require('ws')
Events = require('events').EventEmitter

###
'Rockets' client for server-side scripts.
###
module.exports = class Client extends Events

  # Attempts to create a new socket connection to the command center.
  connect: () ->
    try
      @socket = new Socket('ws://rockets.cc:3210')
      @register()
    catch error
      @onerror error


  # Registers events on the socket connection.
  register: () ->
    @socket.on 'open', @onconnect.bind(@)
    @socket.on 'close', @onclose.bind(@)
    @socket.on 'error', @onerror.bind(@)
    @socket.on 'message', @onmessage.bind(@)


  # Parses an incoming message, checking if it's an error or a model.
  parseMessage: (message) ->
    data = JSON.parse(message)
    if 'error' of data then @onerror data else @onmodel data


  # Called when an incoming message was a model.
  onmodel: (model) ->
    @emit 'model', model

    switch model.kind
      when 't1' then @emit 'comment', model
      when 't3' then @emit 'post', model


  # Called when the socket connection receives a message.
  onmessage: (message) ->
    @parseMessage(message)


  # Called when the socket connection is established.
  onconnect: () ->
    @emit 'connect'


  # Called when the socket connection is lost.
  onclose: () ->
    @emit 'disconnect'


  # Called when the client encounters an error.
  onerror: (error) ->
    @emit 'error', error


  # Attempts to reconnect to the server.
  reconnect: () ->
    if not @available() and not @connecting()
      @connect()
      setTimeout @reconnect.bind(@), 1000


  # Determines whether the socket connection is currently available.
  available: () ->
    return @socket?.readyState == Socket.OPEN


  # Determines whether the socket connection is becoming available.
  connecting: () ->
    return @socket?.readyState == Socket.CONNECTING


  # Subscribes to a channel with a given set of filters.
  subscribe: (channel, include, exclude) ->
    @socket.send JSON.stringify {channel, include, exclude}


  # Closes the socket connection.
  close: () ->
    @socket.removeAllListeners()
    @socket.close()
    @onclose()
