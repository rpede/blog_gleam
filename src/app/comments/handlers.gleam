import app/comments/data.{type Comment}
import gleam/int
import gleam/json
import gleam/option
import gleam/result
import wisp.{type Request}

pub fn list_comments(_: Request) {
  let comments = data.list_comments()
  json.array(comments, fn(a) { to_json(a) })
}

pub fn get_article(_: Request, id: String) {
  let result = {
    use id <- result.try(int.parse(id))
    use article <- result.try(data.get_comments(id))
    Ok(to_json(article))
  }
  option.from_result(result)
}

fn to_json(comment: Comment) {
  json.object([
    #("id", json.int(comment.id)),
    #("article_id", json.int(comment.article_id)),
    #("content", json.string(comment.content)),
  ])
}
