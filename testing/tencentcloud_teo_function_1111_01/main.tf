provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================


resource "tencentcloud_teo_function_1111_01" "example" {
  zone_id = "zone-2p6gh1xjqwbv"
  name    = "tf-test-function-1111-01"
  content = "addEventListener('fetch', (event) => { event.respondWith(handleRequest(event)); }); async function handleRequest(event) { return new Response('Hello World!'); }"
  remark  = "created by terraform test"
}
