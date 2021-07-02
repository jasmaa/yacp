@val external addEventListener: (string, Http.event => unit) => unit = "addEventListener"

let handleRequest = _request => {
  let req = Http.Request.make2("https://google.com", Http.Request.makeInit(~method="GET", ()))

  Http.fetch(req)->Js.Promise.then_(res => {
    Js.Promise.resolve(
      Http.Response.make2(
        res["status"]->Belt.Int.toString,
        Http.Response.makeInit(~headers=Js.Dict.fromArray([("Content-Type", "text/plain")]), ()),
      ),
    )
  }, _)
}

addEventListener("fetch", event => {
  event->Http.respondWith(handleRequest(event["request"]))
})
