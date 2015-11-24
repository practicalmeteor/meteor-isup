log = new ObjectLogger("practical.router.isup")

# Listen to incoming http requests
WebApp.connectHandlers.use "/isup", (req, res, next) ->
  try
    log.enter("isUpUrlHandler", req.url)

    doc = IsUp.findOne()
    status = doc?.status || "404 Not found"
    statusCode = if doc?.status? then 200 else 404
    log.debug("status", status)
    log.debug("statusCode", statusCode)

    res.writeHead(statusCode, {'Content-Type': 'text/plain'})
    res.write(status)
    res.end()
  finally
    log.return()
