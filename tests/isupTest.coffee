log = new ObjectLogger("isupTests", "debug")

describe "isup", ->

  stubCreated = null

  if Meteor.isServer
    Meteor.methods({
      "createStub": ->
        stubs.create("isup.findOne", isup, "findOne")
        return true
      "restoreStub": ->
        stubs.restore("isup.findOne")
        return true
    })

  if Meteor.isClient
    beforeEach ->
      stubCreated = false
      @url = window.location.protocol + "//" + window.location.host + "/isup"
      log.debug("url:", @url)

    afterEach (done)->
      try
        log.enter 'afterEach'
        if stubCreated isnt true
          done()
          return
        log.debug "Calling restoreStub"
        Meteor.call "restoreStub", (error, restored)=>
          done(error) if error?
          expect(restored).to.be.true
          done()
      catch ex
        done(ex)
      finally
        log.return()

    it "/isup route", (done)->

      HTTP.get @url, (err, httpResponse)->
        if err?
          done(err)
          return
        try
          log.debug("httpResponse", httpResponse)
          expect(httpResponse.statusCode).to.equal(200)
          expect(httpResponse.content).to.equal("yes")
          done()
        catch ex
          done(ex)



    it "/isup route - 404 not found", (done)->

      Meteor.call "createStub", (error, created)=>
        if error?
          done(error)
          return
        stubCreated = true

        expect(created).to.be.true
        log.debug("stubCreated")

        HTTP.get @url, (err, httpResponse)->
          try
            log.debug("httpResponse", httpResponse)
            expect(err).to.be.ok
            # We ignore the error afterwards, since we expect a 404 error
            err = null

            expect(httpResponse.statusCode).to.equal(404)
            expect(httpResponse.content).to.match(/404/)
            done()
          catch ex
            done(ex)

