Base = require './weya/base'

class SchedulerBase extends Base
 @initialize (@id, @options, @handler, @timezone, @files, @isDone) ->
  @type = @options.type
  @timeOffset = (new Date()).getTimezoneOffset() * 60 * 1000 + @timezone
  @timeOffset = -@timeOffset
  @opt = @options.options
  @_parseOptions?()
  @running = off

  @last = @gap = @key = null

  next = @_nextTime()
  if next?
   times = @files.read @id
   if times?
    @last = times.last
    @gap = times.gap
    @key = times.key
    k = @_key()
    if @key isnt k
     next = @_nextTime()
     @last = @_lastTime()
     @gap = next - @last
     @key = k
   else
    @last = @_lastTime()
    @gap = next - @last

 _key: ->
  throw new Error 'Sheduler::_key() is not implemented'

 _nextTime: ->
  throw new Error 'Sheduler::_nextTime() is not implemented'

 _lastTime: ->
  throw new Error 'Sheduler::_nextTime() is not implemented'

 @listen 'check', ->
  throw new Error 'Sheduler::_nextTime() is not implemented'

module.exports = SchedulerBase
