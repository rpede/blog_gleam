import app/articles/handlers as articles
import app/res
import app/web
import gleam/json
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> index(req)
    ["articles"] -> articles.list_articles(req) |> res.ok
    ["articles", id] -> articles.get_article(req, id) |> res.maybe
    _ -> res.not_found()
  }
}

fn index(_: Request) -> Response {
  let object =
    json.object([
      #("title", json.string("Gleam Blog")),
      #("endpoints", json.array(["/articles", "/articles/:id"], json.string)),
    ])
  res.ok(object)
}
