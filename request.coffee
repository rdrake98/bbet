millis_in_hour = 1000 * 60 * 60

start_of_next = (date, days) ->
  new Date(date.getFullYear(), date.getMonth(), date.getDate() + days).getTime()

class Request
  constructor: (@fuzzy, @start) ->
    @start ||= new Date
    millis = @start.getTime() 
    @period = switch @fuzzy
      when "whenever"
        new RequestPeriod millis
      when "now"
        new RequestPeriod millis, millis + 2 * millis_in_hour
      when "today"
        new RequestPeriod millis, start_of_next(@start, 1)
      when "tomorrow"
        new RequestPeriod millis, start_of_next(@start, 2)
  duration: ->
    @period.duration()
    
class RequestPeriod
  constructor: (@start, @deadline) ->
  contains: (date) ->
    millis = date.getTime() 
    millis >= @start and (not @deadline or millis <= @deadline)
  duration: ->
    if @deadline 
      "#{Math.round (@deadline - @start) / millis_in_hour} hours"
    else 
      "infinite" 
  print: ->
    "From #{new Date @start} to #{if @deadline then new Date @deadline else 'whenever'}"

exports.Request = Request
exports.RequestPeriod = RequestPeriod