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

 _update: ->
  throw new Error 'Sheduler::_update() is not implemented'

 @listen 'check', (Time) ->
  if @running is on
   return
  if Time - @last >= @gap
   @running = on
   @_update()

   done = =>
    o =
     last: @last
     gap: @gap
     key: @key
    @files.write @id, o
    @running = off

   exe = =>
    if @isDone
     @handler done
    else
     @handler()
     done()
   setTimeout exe, 0

module.exports = SchedulerBase
