clone_git_repos.rb
2020 Levi D. Smith - Levi D. Smith

Loops through all of the public and private repositories for a user, and clones them to the local system

Requirements
- Ruby installed - https://github.com/gatechgrad/clone_github_repos
- json gem installed - gem install json
- git installed - https://git-scm.com/
- GitHub Personal Access token
	https://github.com/settings/tokens
	Select Personal access tokens
	Press Generate new token
	Authenticate with GitHub password
	Select repo for scope
	Press Generate token

Setup
- Copy Personal access token value (should be a hexadecimal string), and paste it for the value of API_TOKEN
- Set CLONE_DIR to the directory where the cloned projects should exist (double backslash may be required on Windows)

Running
- Start Git bash
- ruby clone_git_repos.rb