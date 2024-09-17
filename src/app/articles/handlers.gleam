import app/articles/data.{type Article}
import gleam/int
import gleam/json
import gleam/option
import gleam/result
import wisp.{type Request}

pub fn list_articles(_: Request) {
  let articles = data.list_articles()
  json.array(articles, fn(a) { article_to_json(a) })
}

pub fn get_article(_: Request, id: String) {
  let result = {
    use id <- result.try(int.parse(id))
    use article <- result.try(data.get_article(id))
    Ok(article_to_json(article))
  }
  option.from_result(result)
}

fn article_to_json(article: Article) {
  json.object([
    #("id", json.int(article.id)),
    #("title", json.string(article.title)),
    #("content", json.string(article.content)),
  ])
}
