log = new ObjectLogger("IsUpTests", "debug")

describe "IsUp", ->

  beforeEach ->
    @url = Meteor.absoluteUrl("/isup")
    log.debug("url:", @url)
    stubs.create("IsUp.findOne", IsUp, "findOne")

  afterEach ->
    stubs.restoreAll()

  it "/isup route", ->
    status = "yes"
    stubs.get("IsUp.findOne").returns({status: status})

    httpResponse = HTTP.get(@url)
    log.debug("httpResponse", httpResponse)

    expect(httpResponse.content).to.equal(status)
    expect(httpResponse.statusCode).to.equal(200)

  it "/isup route - 404 not found", (done)->

    HTTP.get @url, (err, httpResponse)->
      log.debug("httpResponse", httpResponse)

      expect(httpResponse.content).to.match(/404/)
      expect(httpResponse.statusCode).to.equal(404)
      done()

