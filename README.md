# init-me
init-me installs all needed packages for a frictionless development environment. Customized for me if ever I need to switch to another laptop or machine.

# Quickstart

## Step 1: Download and execute the bash script
```
curl -s https://raw.githubusercontent.com/PabloTheDeveloper/init-me/main/install.sh > init.sh
```

Or copy the contents of the `install.sh` function and run in your terminal.

# Development Roadmap
(TODO: I should probably use Github's Project page)


## 1. Preparing WSL, Github, Docker
- [x] Setup WSL2 on Laptop
- [x] Setup Github & Git fully  
- [x] auto install docker on WSL2

## 2.1.1 MVP - Get Golang Going - Set up Golang Development Environment (GDE)
- [ ] Start to Handmake:
    - [ ] A Golang CLI tool called 'init-me' that will invoke go-XXXX-me github modules
        - (In the future this will be a binary that developers can install)
    - [ ] A init.lua nvim script for editing Golang
- [ ] Generate Project Scaffolding:
    - [ ] Start another Golang CLI tool claled `go-scaffold-me`
    - [ ] template README.md, & source files, and add test
    - [ ] Set up a Golang Dockerfile
        - It will assume gh, docker, and A Dockerfile exists
    - [ ] Verify `go-scaffold-me` works
- [ ] CI/CD Setup Automation:
    - [ ] CI w/ Github Actions
    - [ ] CD w/ Github Actions
- [ ] Build Project Site w/Github Pages
    - (These are always public even if repo is private)`
    - [ ] Find theme for CLI projects
        - (color themed for what kind of project they are)
        - (python should have a python, golang a gopher - maybe animations??)
        - (Should have a worklog or knowledgelog. Should sync to personal notes somehow)
- [ ] Mandate Github issue tracking for any new change
    - [ ] Transition existing project to have this template. Maybe update git commits?
- [ ] Dockerfile & DockerCompose for:
    - [ ] NVIM
    - [ ] Golang
## 2.1.2 MVP - Webbing Golang - Setup Golang Templates for Web Projects
- [ ] Start to Handmake:
    - [ ] Basic Static Website
        - [ ] Updating `go-scaffold-me` for this template
        - [ ] Deploying on Digital Ocean
    - [ ] Form generating site w/ persistence (like formly but w/ GUI)
        - [ ] Allows authenticated users (email & password)
        - [ ] Allow them to delete their accounts and all their data
        - [ ] Allows Admin to create groups via email
        - [ ] Allows them to modify/delete their group 
        - [ ] Allows admin to create prompt for their group
        - [ ] add prompt for their group
        - [ ] Deletion of user from group doesn't delete
        - [ ] Allow creation of a prompt e.g "site.com/blog/entry/<Prompt-Title>"
        - [ ] Allows creation of a private link for users to edit a prompt
           - [ ] Admins of prompt can generate signed in links w/ temporary passcodes for users
        - [ ] Lets Users see all their posts
        - [ ] Lets Users see all their posts in a group
        - [ ] Lets Users make their post private/public or delete
        - [ ] Allows users to update the What prompts they've made visible
        - [ ] Must support mobile platforms
- [ ] Dockerfile & DockerCompose for:
    - [ ] MySQL/Postgres
    - [ ] Golang
## 2.1.3 Production Tier Golang: Redis + Golang + MySQL
- [ ] Make a Social Meetup App
    - [ ] Supports scheduling + Location
    - [ ] Creating chat rooms (in Instagram)
    - [ ] Finding things to do (collecting previous things done)

- [ ] Verify by making a collaborative group writing
## 2.2.1 MVP - Flying Flutter - Setup Flutter Development Environment (FDE)
- [ ] [Flutter](https://blog.codemagic.io/how-to-dockerize-flutter-apps/)
- [ ] Make project that creates an App Browser with no javascript
## 2.2.2 
- [ ] Journal App
# ? Misc.
- [ ] install sway and related configs

