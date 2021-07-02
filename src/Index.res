@val external addEventListener: (string, Http.event => unit) => unit = "addEventListener"

let handleRequest = (_request) => {

    let req = Http.makeRequest(
        "https://google.com",
        Http.makeRequestInit(~method="GET", ()),
    )

    Js.Promise.resolve(
        Http.makeResponse2(
            "Hello world",
            Http.makeResponseInit(~headers=Js.Dict.fromArray([
                ("Content-Type", "text/plain"),
            ]), ()),
        )
    )
}

addEventListener("fetch", event => {
    event->Http.respondWith(handleRequest(event["request"]))
})