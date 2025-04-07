# KV Store API

A simple Key-Value Store built with Phoenix Framework. This API allows  to perform basic operations (create, retrieve, delete) on key-value pairs.


From the root of the project, run:
docker build -t kv-store .
docker run -d -p 4000:4000 kv-store

POST /api/kv
Store a new key-value pair.

Request Body:
json
{
  "key": "string",
  "value": "string"
}

GET /api/kv/:key
Retrieve the value associated with the given key.

Response:
json
{
  "key": "test",
  "value": "hello"
}

DELETE /api/kv/:key
Delete a key-value pair.

Response:
json
{
  "status": "success",
  "message": "Key-value pair deleted successfully."
}