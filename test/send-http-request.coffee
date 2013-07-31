require("mocha-as-promised")()

http = require "http"
send = require "../"
assert = require "assert"

port = 39451  # somewhat random

describe "sendHTTPRequest", ->
  it "sends http request", ->
    server = http.createServer()
    server.on "request", (req, res) ->
      res.statusCode = 200
      res.setHeader "content-type","text/plain"
      res.end "It worked."
    server.listen port
    send("GET","http://127.0.0.1:#{port}").then (response) ->
      assert.equal response.getStatusCode(), 200
      assert.equal response.getText(), "It worked."