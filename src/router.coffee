log = new ObjectLogger("practicalmeteor:isup")

# Listen to incoming http requests
WebApp.connectHandlers.use "/isup", (req, res, next) ->
  try
    log.enter("WebApp.connectHandlers.isup", req.url)

    doc = isup.findOne()
    statusCode = if doc?.isup? then 200 else 404
    content = doc?.isup || "404 Not found"
    log.debug("statusCode", statusCode)
    log.debug("isup", content)

    res.writeHead(statusCode, {'Content-Type': 'text/plain'})
    res.write(content)
    res.end()
  finally
    log.return()
