{Request, RequestPeriod} = require '../request'

# better to mock time zones in perfect world
gmt = ->
  process.env.TZ == "GMT"
japan = ->
  process.env.TZ == "Japan"

date1 = new Date Date.parse "2013-02-03T21:31:27.847"
date2 = new Date Date.parse "2013-02-28T13:07:23.543"
date3 = new Date Date.parse "3000-01-01"

describe 'Dates', ->
  # for clarity of next block only
  it 'has these millis', ->
    date1.getTime().should.equal 1359927087847
    date2.getTime().should.equal 1362056843543

describe 'RequestPeriod', ->
  rp = new RequestPeriod 1359927087847, 1362056843543
  
  it 'should contain intermediates', ->
    rp.contains(new Date 1350000000000).should.be.false
    rp.contains(new Date 1360000000000).should.be.true
    rp.contains(new Date 1370000000000).should.be.false
    rp.contains(date3).should.be.false
    
  if gmt()
    it 'should show range', ->
      rp.print().should.equal "From Sun Feb 03 2013 21:31:27 GMT+0000 (GMT) to Thu Feb 28 2013 13:07:23 GMT+0000 (GMT)" 
      
  rp2 = new RequestPeriod 1359927087847
  
  it 'should contain anything in the future', ->
    rp2.contains(new Date 1350000000000).should.be.false
    rp2.contains(date3).should.be.true 
    
  it 'should sound like a teenager', ->
    rp2.print().should.match(/whenever$/)

describe 'Request', ->
  request_whenever = new Request "whenever"
  request_now = new Request "now", date2
  request_today = new Request "today", date2
  request_tomorrow = new Request "tomorrow", date2
  
  it 'should be there', ->
    request_whenever.should.exist
    request_now.should.exist
    
  it 'should have the right duration', ->
    request_whenever.duration().should.equal "infinite"
    request_now.duration().should.equal "2 hours"
    if gmt()
      request_today.duration().should.equal "11 hours"
      request_tomorrow.duration().should.equal "35 hours"
    if japan() # 9 hours ahead of us
      request_today.duration().should.equal "2 hours"
      request_tomorrow.duration().should.equal "26 hours"