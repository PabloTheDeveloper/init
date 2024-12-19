#!/bin/bash

# Required for 'gh auth login' to work
# See https://cli.github.com/manual/gh_auth_login
function set_gh_token_env() {
  echo "Enter GH_TOKEN:"
  read gh_token
  export GH_TOKEN="$gh_token"
}

