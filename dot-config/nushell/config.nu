# Shared Nushell configuration for macOS and Linux.

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.COMPOSER_HOME = ($env.HOME | path join ".composer")
$env.DOTFILES = ($nu.config-path | path expand | path dirname | path dirname | path dirname)

if ($env.PROJECTS? | is-empty) {
    $env.PROJECTS = if $nu.os-info.name == "macos" {
        $env.HOME | path join "Documents" "Code"
    } else {
        $env.HOME | path join "Code"
    }
}

let preferred_paths = [
    ($env.HOME | path join ".local" "bin")
    ($env.HOME | path join ".bin")
    ($env.HOME | path join ".bm")
    ($env.HOME | path join ".composer" "vendor" "bin")
    ($env.HOME | path join ".config" "composer" "vendor" "bin")
    ($env.PROJECTS | path join "go" "bin")
    "/usr/local/go/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/usr/local/bin"
]
$env.PATH = ($preferred_paths | append $env.PATH | flatten | uniq)
$env.GOPATH = ($env.PROJECTS | path join "go")

$env.config.show_banner = false
$env.config.buffer_editor = "nvim"
$env.config.edit_mode = "vi"
$env.config.history.file_format = "sqlite"
$env.config.history.max_size = 100_000
$env.config.history.sync_on_enter = true
$env.config.completions.case_sensitive = false
$env.config.completions.quick = true
$env.config.completions.partial = true
$env.config.completions.algorithm = "fuzzy"

# Shell shortcuts carried over from the former zsh setup.
alias c = clear
alias e = exit
alias tf = ^tail -f
alias cat = ^bat

alias gl = ^git pull --prune
alias glog = ^git log --graph --pretty="format:%C(red)%h%Creset %an: %s - %C(yellow)%d%Creset %C(green)(%cr)%Creset" --abbrev-commit --date=relative
alias gp = ^git push origin HEAD
alias gd = ^git diff
alias gc = ^git commit -v
alias gca = ^git commit -a
alias gco = ^git checkout
alias gcb = ^git copy-branch-name
alias gb = ^git branch
alias gs = ^git status -sb

alias dm = ^docker-machine
alias dma = ^docker-machine active
alias dc = ^docker-compose

def --wrapped dcr [...args] {
    ^docker-compose run --rm ...$args
}

def --wrapped sail [...args] {
    ^./vendor/bin/sail ...$args
}

def --wrapped vessel [...args] {
    ^./vessel ...$args
}

def --wrapped artisan [...args] {
    ^php artisan ...$args
}

alias a = artisan
alias tinker = ^php artisan tinker
alias serve = ^php artisan serve
alias mfs = ^php artisan migrate:fresh --seed

def "nu-complete projects" [] {
    let projects = ($env.PROJECTS | path expand)
    if ($projects | path exists) {
        ls $projects | where type == dir | get name | path basename
    } else {
        []
    }
}

def --env p [project?: string@"nu-complete projects"] {
    let destination = if ($project | is-empty) {
        $env.PROJECTS
    } else {
        $env.PROJECTS | path join $project
    }

    if ($destination | path exists) {
        cd $destination
        clear
    } else {
        error make {msg: $"($destination) does not exist"}
    }
}

alias mycode = p

def --wrapped satis [...args] {
    let composer_home = ($env.COMPOSER_HOME? | default ($env.HOME | path join ".composer"))
    let user_id = (^id -u | str trim)
    let group_id = (^id -g | str trim)
    let docker_args = [
        "run" "--rm" "--init" "-it"
        "--user" $"($user_id):($group_id)"
        "--volume" $"(pwd):/build"
        "--volume" $"($composer_home):/composer"
        "composer/satis"
    ]
    ^docker ...$docker_args ...$args
}

def --env reload-shell [] {
    if (which direnv | is-not-empty) {
        let result = (do { ^direnv status } | complete)
        if not ($result.stdout | str contains "No .envrc found") {
            ^direnv reload
        }
    }
    exec nu
}

alias r = reload-shell
alias h = ^herdr

# Nushell's `open` is useful for data. Use this for the platform GUI opener.
def sys-open [target: path] {
    if $nu.os-info.name == "macos" {
        ^open $target
    } else {
        ^xdg-open $target
    }
}

# Keep machine-specific environment values out of the repository. This file is
# optional and may define environment variables, aliases, or commands.
const local_config = if (($nu.default-config-dir | path join "local.nu") | path exists) {
    $nu.default-config-dir | path join "local.nu"
} else {
    null
}
source $local_config

# A local PROJECTS override should also update its derived Go locations.
$env.GOPATH = ($env.PROJECTS | path join "go")
$env.PATH = ([($env.GOPATH | path join "bin")] | append $env.PATH | flatten | uniq)
