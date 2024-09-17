import app/articles/handlers as article
import app/comments/handlers as comment
import app/res
import app/web
import gleam/json
import wisp.{type Request, type Response}

pub fn handle_request(req: Request) -> Response {
  use req <- web.middleware(req)

  case wisp.path_segments(req) {
    [] -> index(req)
    ["articles"] -> article.list_articles(req) |> res.ok
    ["articles", id] -> article.get_article(req, id) |> res.maybe
    ["comments"] -> comment.list_comments(req) |> res.ok
    ["comments", id] -> comment.get_article(req, id) |> res.maybe
    _ -> res.not_found()
  }
}

fn index(_: Request) -> Response {
  let object =
    json.object([
      #("title", json.string("Gleam Blog")),
      #(
        "endpoints",
        json.array(
          ["/articles", "/articles/:id", "/comments", "/comments/:id"],
          json.string,
        ),
      ),
    ])
  res.ok(object)
}
