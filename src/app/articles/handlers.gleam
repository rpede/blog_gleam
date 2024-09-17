import app/articles/data.{type Article}
import app/res
import gleam/int
import gleam/json
import gleam/option
import gleam/result
import wisp.{type Request}

pub fn list_articles(_: Request) {
  let articles = data.list_articles()
  json.array(articles, to_json(_))
  |> res.ok
}

pub fn get_article(_: Request, id: String) {
  let result = {
    use id <- result.try(int.parse(id))
    use article <- result.try(data.get_article(id))
    Ok(to_json(article))
  }
  option.from_result(result)
  |> res.maybe
}

fn to_json(article: Article) {
  json.object([
    #("id", json.int(article.id)),
    #("title", json.string(article.title)),
    #("content", json.string(article.content)),
  ])
}
