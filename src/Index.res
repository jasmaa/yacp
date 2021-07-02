@val external addEventListener: (string, Http.event => unit) => unit = "addEventListener"

let handleRequest = request => {
  let url = Url.make(request["url"])
  let searchParams = Url.SearchParams.make(url["search"])

  switch searchParams->Url.SearchParams.get("targetURL")->Js.Nullable.toOption {
  | Some(targetUrl) =>
    // Fetch targetUrl if found
    let req = Http.Request.make2(targetUrl, Http.Request.makeInit(~method="GET", ()))
    Http.fetch(req)->Js.Promise.then_(res => {
      Js.Promise.resolve(res)
    }, _)->Js.Promise.catch(_err => {
      Js.Promise.resolve(
        Http.Response.make2(
          "could not resolve targetURL",
          Http.Response.makeInit(
            ~status=400,
            ~headers=Js.Dict.fromArray([("Content-Type", "text/plain")]),
            (),
          ),
        ),
      )
    }, _)
  | None =>
    // No targetUrl provided
    Js.Promise.resolve(
      Http.Response.make2(
        "no targetURL provided",
        Http.Response.makeInit(
          ~status=400,
          ~headers=Js.Dict.fromArray([("Content-Type", "text/plain")]),
          (),
        ),
      ),
    )
  }
}

addEventListener("fetch", event => {
  event->Http.respondWith(handleRequest(event["request"]))
})
