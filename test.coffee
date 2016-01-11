Scheduler = require './scheduler'
debugger
Scheduler = new Scheduler +5.5, './', 5000
Scheduler.addEvent 'event1',
 {
  type: 'interval'
  options:
   interval: 5000
   runOnStart: on
 }
 ->
  console.log 'called interval'

Scheduler.addEvent 'event2',
 {
  type: 'hourly'
  options:
   minute: 24
 }
 ->
  console.log 'called hourly'

Scheduler.addEvent 'event_daily',
 {
  type: 'daily'
  options:
   hour: 18
   minute: 45
 }
 ->
  console.log 'called daily'

Scheduler.addEvent 'event_weekly',
 {
  type: 'weekly'
  options:
   day: 'mon'
   hour: 18
   minute: 48
 }
 ->
  console.log 'called weekly'

Scheduler.addEvent 'event_monthly',
 {
  type: 'monthly'
  options:
   date: 11
   hour: 18
   minute: 54
 }
 ->
  console.log 'called monthly'

Scheduler.start()
