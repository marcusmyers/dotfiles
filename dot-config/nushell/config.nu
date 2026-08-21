# Shared Nushell configuration for macOS and Linux.

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"
$env.COMPOSER_HOME = ($env.HOME | path join ".composer")
$env.DOTFILES = ($nu.config-path | path expand | path dirname | path dirname | path dirname)
$env.DEFAULT_USER = ($env.USER? | default ($env.USERNAME? | default ""))

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

# Omarchy environment, shortcuts, helpers, and dynamic command completion.
const omarchy_config = if ($nu.os-info.name == "linux" and (($nu.default-config-dir | path join "omarchy.nu") | path exists)) {
    $nu.default-config-dir | path join "omarchy.nu"
} else {
    "/dev/null"
}
source $omarchy_config

# Shell shortcuts carried over from the former zsh setup.
alias cls = clear
alias e = exit
alias tf = ^tail -f
alias cat = ^bat

alias gl = ^git pull --prune
alias glog = ^git log --graph --pretty="format:%C(red)%h%Creset %an: %s - %C(yellow)%d%Creset %C(green)(%cr)%Creset" --abbrev-commit --date=relative
alias gp = ^git push origin HEAD
alias gdiff = ^git diff
alias gc = ^git commit -v
alias gca = ^git commit -a
alias gco = ^git checkout
alias gcb = ^git copy-branch-name
alias gb = ^git branch
alias gs = ^git status -sb
alias gst = ^git status

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

alias pa = artisan
alias tinker = ^php artisan tinker
alias serve = ^php artisan serve
alias mfs = ^php artisan migrate:fresh --seed

def "nu-complete projects" [] {
    let projects = ($env.PROJECTS | path expand)
    if ($projects | path exists) {
        glob ($projects | path join "**" ".git") --depth 3
            | each { |git_dir| $git_dir | path dirname | path relative-to $projects }
            | sort
            | uniq
    } else {
        []
    }
}

def --env p [project?: string@"nu-complete projects"] {
    let projects = ($env.PROJECTS | path expand)
    let destination = if ($project | is-empty) {
        $projects
    } else {
        let direct = ($projects | path join $project)

        if ($direct | path exists) {
            $direct
        } else {
            let matches = (nu-complete projects | where { |candidate|
                ($candidate | path basename) == $project
            })

            match ($matches | length) {
                1 => ($projects | path join ($matches | first))
                0 => (error make {msg: $"Project '($project)' does not exist"})
                _ => (error make {
                    msg: $"Project '($project)' is ambiguous"
                    help: $"Use one of: ($matches | str join ', ')"
                })
            }
        }
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

alias reload = reload-shell
alias h = ^herdr
alias attack = ^siege -t20s -b -c1

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

# Preserve the tmux status formatting that used to run from .zshrc.
if (($env.TMUX? | is-not-empty) and (which tmux | is-not-empty)) {
    for setting in [
        ["window-status-format" "#I:#{b:pane_current_path}"]
        ["window-status-current-format" "#I@#{b:pane_current_path}"]
        ["status-left" " "]
        ["status-right" " %Y-%m-%d %H:%M:%S "]
    ] {
        do { ^tmux set -g $setting.0 $setting.1 } | complete | ignore
    }
}

# Powerlevel10k only runs in zsh. Oh My Posh uses the tracked p10k-style theme
# to provide the same path, Git, language, status, timing, and clock segments.
# For Nu, this command writes the generated integration to the vendor autoload
# directory. Nushell loads that file on the next startup; --print is the mode
# that emits the generated script to stdout.
if (which oh-my-posh | is-not-empty) {
    oh-my-posh init nu --config ($env.HOME | path join ".config" "oh-my-posh" "mark.json")
}
