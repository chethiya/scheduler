Base = require './base'

HOUR = 60 * 60 * 1000

class HourlyScheduler extends Base
 @extend()

 _key: -> @min

 _parseOptions: ->
  @min = parseInt @opt.minute
  if not @min? or isNaN @min
   throw new Error "Scheduler missing/invalid minute value in scheduler #{@id}"
  @min = @min % 60

 _nextTime: ->
  d = new Date
  m = d.getMinutes()
  h = d.getHours()
  dd = new Date d.getFullYear(), d.getMonth(), d.getDate(), h, @min
  time = dd.getTime()
  if @min <= m
   time += HOUR
  return time + @timeOffset

 _lastTime: -> @_nextTime() - HOUR

 @listen 'check', (Time) ->
  if @running is on
   return
  if Time - @last >= @gap
   @running = on
   @last = @_lastTime()

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

module.exports = (Types) ->
 Types.hourly = HourlyScheduler
