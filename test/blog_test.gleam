import app/router
import gleam/string
import gleeunit
import gleeunit/should
import wisp/testing

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn index_test() {
  let response = router.handle_request(testing.get("/", []))

  response.status
  |> should.equal(200)

  let body =
    response
    |> testing.string_body

  body
  |> string.contains("/articles")
  |> should.be_true

  body
  |> string.contains("/comments")
  |> should.be_true
}

pub fn articles_test() {
  let response = router.handle_request(testing.get("/articles", []))

  response.status
  |> should.equal(200)

  let body =
    response
    |> testing.string_body

  body
  |> string.contains("First article")
  |> should.be_true

  body
  |> string.contains("Second article")
  |> should.be_true
}

pub fn articles_id_test() {
  let response = router.handle_request(testing.get("/articles/2", []))

  response.status
  |> should.equal(200)

  response
  |> testing.string_body
  |> string.contains("Second article")
  |> should.be_true
}
