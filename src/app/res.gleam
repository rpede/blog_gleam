import gleam/json
import gleam/option.{type Option}
import wisp

pub fn maybe(json: Option(json.Json)) {
  case json {
    option.Some(json) -> ok(json)
    _ -> not_found()
  }
}

pub fn ok(json: json.Json) {
  json_response(json, 200)
}

pub fn not_found() {
  let json = json.object([#("message", json.string("Not found"))])
  json_response(json, 404)
}

fn json_response(json: json.Json, status: Int) {
  wisp.json_response(json.to_string_builder(json), status)
}
