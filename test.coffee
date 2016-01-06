Scheduler = require './scheduler'
debugger
Scheduler = new Scheduler +5.5, './', 5000
Scheduler.addEvent 'event1',
 {
  type: 'interval'
  options:
   interval: 5000
 }
 ->
  console.log 'called 1 min interval'

Scheduler.addEvent 'event2',
 {
  type: 'hourly'
  options:
   minute: 38
 }
 ->
  console.log 'called hourly'

Scheduler.addEvent 'event_daily',
 {
  type: 'daily'
  options:
   hour: 22
   minute: 42
 }
 ->
  console.log 'called daily'


Scheduler.start()
