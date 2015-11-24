log = new ObjectLogger("isupTests", "debug")

describe "isup", ->

  beforeEach ->

    if Meteor.isClient
      @url = window.location.protocol + "//" + window.location.host + "/isup"
    else
      @url = Meteor.absoluteUrl("isup")

    log.debug("url:", @url)

  afterEach ->
    stubs.restoreAll()

  if Meteor.isClient
    it "/isup route", (done)->

      HTTP.get @url, (err, httpResponse)->
        err = null
        log.debug("httpResponse", httpResponse)
        try
          expect(httpResponse.content).to.equal("yes")
          expect(httpResponse.statusCode).to.equal(200)
        catch ex
          err = ex

        done(err)

  if Meteor.isServer
    it "/isup route - 404 not found", (done)->
      stubs.create("isup.findOne", isup, "findOne")

      HTTP.get @url, (err, httpResponse)->
        err = null
        try
          log.debug("httpResponse", httpResponse)

          expect(httpResponse.content).to.match(/404/)
          expect(httpResponse.statusCode).to.equal(404)
        catch ex
          err = ex

        stubs.restoreAll()

        done(err)

