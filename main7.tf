provider "github" {
  token = "you have to provide the token here generated from github developer setting"
}

resource "github_repository" "firstrepo-terraform" {
  name        = "firstrepofromterraform"
  description = "My awesome codebase"
  visibility = "public"
  auto_init=true
}
