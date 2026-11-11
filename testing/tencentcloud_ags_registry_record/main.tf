provider "tencentcloud" {
  region     = var.region
  secret_id  = var.secret_id
  secret_key = var.secret_key
}

# ==============================================================================
# Resource / data / action block(s) for the resource under test are appended
# below by the agent. Do not remove or modify the provider block above.
# ==============================================================================

resource "tencentcloud_ags_registry_record" "example" {
  registry_id     = "registry-abcdef12"
  name            = "tf-test-ags-registry-record"
  descriptor_type = "MCP"
  description     = "Test record created by terraform"
  version_name    = "v1.0.0"

  mcp_source = {
    type         = "MANUAL"
    descriptors  = jsonencode({ mcpServers = { test = { command = "node" } } })
    endpoint_url = "https://example.com/server.json"
  }

  agent_source = {
    type         = "URL_IMPORT"
    descriptors  = jsonencode({ name = "test-agent" })
    endpoint_url = "https://example.com/agent.json"
  }

  skill_source = {
    type     = "MANUAL"
    skill_md = "---\nname: test-skill\ndescription: test\n---\n# Test Skill"
  }

  custom_descriptors = jsonencode({ custom = "descriptor" })

  label_mutations = [
    {
      operation  = "SET"
      name       = "env-test"
      version_id = "rv-12345678"
      reason     = "terraform test"
    },
  ]

  reason = "terraform test cleanup"
}

import {
  to = tencentcloud_ags_registry_record.example
  id = "registry-abcdef12#rec-12345678"
}
