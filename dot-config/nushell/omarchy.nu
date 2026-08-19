# Nushell integration for Omarchy's interactive Bash defaults.
# Re-run `sync-omarchy-nushell` after an Omarchy/tool update to refresh the
# generated mise/zoxide integration and report changes to upstream defaults.

if $nu.os-info.name == "linux" and ("/usr/share/omarchy" | path exists) {
    $env.OMARCHY_PATH = ($env.OMARCHY_PATH? | default "/usr/share/omarchy")
    $env.EDITOR = ($env.EDITOR? | default "omarchy-launch-editor --inline")
    $env.SUDO_EDITOR = $env.EDITOR
    $env.BROWSER = ($env.BROWSER? | default "omarchy-launch-browser")
    $env.BAT_THEME = "ansi"
    $env.MANROFFOPT = "-c"
    $env.MANPAGER = "sh -c 'col -bx | bat -l man -p'"
    $env.PATH = ($env.PATH | append ($env.HOME | path join ".local" "bin") | uniq)
}

# File-system shortcuts. `ls` remains Nushell's structured command; `ll` and
# friends provide Omarchy's eza presentation without taking that capability away.
alias ll = ^eza -lh --group-directories-first --icons=auto
alias lla = ^eza -lha --group-directories-first --icons=auto
alias lt = ^eza --tree --level=2 --long --icons --git
alias lta = ^eza --tree --level=2 --long --icons --git -a

def --env --wrapped zd [...args: string] {
    if ($args | is-empty) {
        cd $env.HOME
    } else if (($args | length) == 1 and ($args.0 | path type) == "dir") {
        cd $args.0
    } else if (which zoxide | is-not-empty) {
        let destination = (^zoxide query ...$args | str trim)
        if ($destination | is-empty) { error make {msg: "Directory not found"} }
        cd $destination
    } else {
        error make {msg: "Directory not found (and zoxide is unavailable)"}
    }
    print $"󱞩 (pwd)"
}

def --env .. [] { zd .. }
def --env ... [] { zd ../.. }
def --env .... [] { zd ../../.. }

def --wrapped ff [...args: string] {
    if ($env.TERM? | default "") == "xterm-kitty" {
        ^fzf --preview 'case $(file --mime-type -b {}) in image/*) kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} ;; *) bat --style=numbers --color=always {} ;; esac' ...$args
    } else {
        ^fzf --preview 'bat --style=numbers --color=always {}' ...$args
    }
}

def eff [] {
    let selected = (ff | str trim)
    if ($selected | is-not-empty) { run-external ...($env.EDITOR | split row " ") $selected }
}

def sff [destination: string] {
    let selected = (
        ^find . -type f -printf '%T@\t%p\n'
        | lines
        | sort --reverse
        | each {|line| $line | split row "\t" | skip 1 | str join "\t" }
        | str join (char nl)
        | ff
        | str trim
    )
    if ($selected | is-not-empty) { ^scp $selected $destination }
}

alias a = ^omarchy-agent --inline
alias c = ^opencode --auto
def --wrapped cx [...args: string] {
    print -n $"(ansi cls)(ansi erase_scrollback)(ansi home)"
    ^claude --permission-mode bypassPermissions ...$args
}
alias cy = ^codex -s danger-full-access -a never
alias d = ^docker
alias r = ^rails
alias t = ^tmux new-session -A -s Work
alias ic = ^tdl c
alias ix = ^tdl cx
alias icx = ^tdl c cx
alias g = ^git
alias gcm = ^git commit -m
alias gcam = ^git commit -a -m
alias gcad = ^git commit -a --amend

def --wrapped mup [...args: string] {
    with-env { MISE_MINIMUM_RELEASE_AGE: "0" } { ^mise up ...$args }
}

def --wrapped n [...args: string] {
    if ($args | is-empty) { ^nvim . } else { ^nvim ...$args }
}

def compress [target: path] { ^tar -czf $"($target | str trim --right --char '/').tar.gz" ($target | str trim --right --char '/') }
def decompress [archive: path] { ^tar -xzf $archive }

# Run one of Omarchy's Bash helper functions against the installed version.
# Positional parameters avoid shell interpolation of user-provided arguments.
def --wrapped omarchy-bash-helper [name: string, ...args: string] {
    ^bash --noprofile --norc -c '
        set -o pipefail
        OMARCHY_PATH=${OMARCHY_PATH:-/usr/share/omarchy}
        for file in "$OMARCHY_PATH"/default/bash/fns/*; do source "$file"; done
        function_name=$1; shift
        "$function_name" "$@"
    ' omarchy-nu $name ...$args
}

def --wrapped iso2sd [...args: string] { omarchy-bash-helper iso2sd ...$args }
def --wrapped format-drive [...args: string] { omarchy-bash-helper format-drive ...$args }
def --wrapped hdl [...args: string] { omarchy-bash-helper hdl ...$args }
def --wrapped hds [...args: string] { omarchy-bash-helper hds ...$args }
def --wrapped hdlm [...args: string] { omarchy-bash-helper hdlm ...$args }
def --wrapped hsl [...args: string] { omarchy-bash-helper hsl ...$args }
def --wrapped tdl [...args: string] { omarchy-bash-helper tdl ...$args }
def --wrapped tds [...args: string] { omarchy-bash-helper tds ...$args }
def --wrapped tdlm [...args: string] { omarchy-bash-helper tdlm ...$args }
def --wrapped tsl [...args: string] { omarchy-bash-helper tsl ...$args }
def --wrapped rsw [...args: string] { omarchy-bash-helper rsw ...$args }
def lsw [] { omarchy-bash-helper lsw }
def dsw [] { omarchy-bash-helper dsw }
def --wrapped fip [...args: string] { omarchy-bash-helper fip ...$args }
def --wrapped dip [...args: string] { omarchy-bash-helper dip ...$args }
def lip [] { omarchy-bash-helper lip }
def --wrapped ssh [...args: string] { omarchy-bash-helper ssh ...$args }

# Worktree helpers must be native because they change the parent Nu directory.
def --env ga [branch: string] {
    let root = (pwd | path basename)
    let destination = (pwd | path dirname | path join $"($root)--($branch)")
    ^git worktree add -b $branch $destination
    if $env.LAST_EXIT_CODE != 0 { return }
    if (which mise | is-not-empty) { ^mise trust $destination }
    cd $destination
}

def --env gd [] {
    let current = (pwd)
    let worktree = ($current | path basename)
    if not ($worktree | str contains "--") { error make {msg: "Current directory does not look like an Omarchy worktree"} }
    let parts = ($worktree | split row "--" --number 2)
    let root = $parts.0
    let branch = $parts.1
    if (^gum confirm "Remove worktree and branch?" | complete).exit_code == 0 {
        cd ($current | path dirname | path join $root)
        ^git worktree remove $current --force
        if $env.LAST_EXIT_CODE == 0 { ^git branch -D $branch }
    }
}

def "nu-complete omarchy" [context: string] {
    let words = ($context | split row " " | where {|word| $word | is-not-empty })
    let entered = ($words | skip 1)
    let current = if ($context | str ends-with " ") { "" } else { $entered | last | default "" }
    let completed = if ($context | str ends-with " ") { $entered } else { $entered | drop }
    let result = (^omarchy commands --json | complete)
    if $result.exit_code != 0 { return [] }
    let data = ($result.stdout | from json)
    $data.commands
    | each {|command|
        let route = ($command.route | split row " " | skip 1)
        if ($route | first ($completed | length)) == $completed {
            $route | get --optional ($completed | length)
        }
    }
    | compact
    | uniq
    | where {|candidate| $candidate | str starts-with $current }
}

export extern "omarchy" [...args: string@"nu-complete omarchy"]

def sync-omarchy-nushell [--check] {
    let script = ($nu.config-path | path dirname | path join "sync-omarchy-nushell")
    if not ($script | path exists) { error make {msg: $"Missing ($script); rerun the dotfiles linker"} }
    if $check { ^$script --check } else { ^$script }
}
