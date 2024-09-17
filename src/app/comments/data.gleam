import gleam/list

pub type Comment {
  Comment(id: Int, article_id: Int, content: String)
}

const comments = [Comment(1, article_id: 1, content: "First one to comment!")]

pub fn list_comments() {
  comments
}

pub fn get_comments(int id) {
  list.find(comments, fn(a) { a.id == id })
}
