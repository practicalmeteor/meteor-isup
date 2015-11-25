log = new ObjectLogger("isupTests", "debug")

describe "isup", ->

  if Meteor.isServer
    Meteor.methods({
      "createStub": ->
        stubs.create("isup.findOne", isup, "findOne")
        return true
      "restoreStub": ->
        stubs.restore("isup.findOne")
    })

  if Meteor.isClient
    beforeEach ->

      @url = window.location.protocol + "//" + window.location.host + "/isup"
      log.debug("url:", @url)


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

    it "/isup route - 404 not found", (done)->

      Meteor.call "createStub", (error, created)=>
        expect(created).to.be.true
        log.debug("stubCreated")

        HTTP.get @url, (err, httpResponse)->
          err = null
          try
            log.debug("httpResponse", httpResponse)

            expect(httpResponse.content).to.match(/404/)
            expect(httpResponse.statusCode).to.equal(404)
          catch ex
            err = ex

          Meteor.call("restoreStub")

          done(err)

