import gleam/list

pub type Article {
  Article(id: Int, title: String, content: String)
}

const articles = [
  Article(1, title: "First article", content: "Breaking news"),
  Article(2, title: "Second article", content: "Another breaking story"),
]

pub fn list_articles() {
  articles
}

pub fn get_article(int id) {
  list.find(articles, fn(a) { a.id == id })
}
