@val external addEventListener: (string, Http.event => unit) => unit = "addEventListener"

let handleRequest = _request => {
  let req = Http.Request.make2("https://google.com", Http.Request.makeInit(~method="GET", ()))

  Js.Promise.resolve(
    Http.Response.make2(
      "Hello world",
      Http.Response.makeInit(~headers=Js.Dict.fromArray([("Content-Type", "text/plain")]), ()),
    ),
  )
}

addEventListener("fetch", event => {
  event->Http.respondWith(handleRequest(event["request"]))
})
