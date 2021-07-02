@val external addEventListener: (string, Http.event => unit) => unit = "addEventListener"

let handleRequest = (_request) => {
    Js.Promise.resolve(
        Http.makeResponse(
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