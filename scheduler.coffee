Files = require './files'
Types = {}
(require './hourly') Types
(require './interval') Types
#(require './daily') Types
#(require './weekly') Types

class Scheduler

 DEFAULT_CHECK_INTERVAL = 5000 #30000 # 30s
 constructor: (timezoneHours, @dir, @interval) ->
  @timezone = timezoneHours * 60 * 60 * 1000
  @interval ?= DEFAULT_CHECK_INTERVAL
  @events = []
  Files = new Files @dir


 addEvent: (id, options, handler, isDone) ->
  type = options.type
  if Types[type]?
   @events.push new Types[type] id, options, handler, @timezone, Files, isDone

 start: ->
  check = =>
   time = (new Date).getTime()
   for e in @events
    e.on.check time
  @iid = setInterval check, @interval

module.exports = Scheduler
