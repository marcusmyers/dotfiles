# Mark's dotfiles

One configuration for macOS, Omarchy/Arch workstations, and Ubuntu/Debian
servers. Nushell is the interactive shell and Herdr is the persistent terminal
workspace manager.

## Install

Clone the repository anywhere, then run:

```sh
./install
```

This installs the platform packages, links the tracked dotfiles into `$HOME`,
and configures Herdr to open Nushell in every new pane. It does **not** change
the account's login shell, so POSIX-dependent system tools continue to work.
Start either tool directly:

```sh
nu
herdr
```

To make Nu the account login shell too:

```sh
./install --set-shell
```

That opt-in adds the resolved `nu` binary to `/etc/shells` and runs `chsh`.
Nushell is not POSIX-compatible, so leaving the login shell unchanged is often
the better choice on servers even though Herdr itself uses Nu.

## Supported systems

| System | Package path | Notes |
| --- | --- | --- |
| macOS (Intel/Apple silicon) | Homebrew | Installs `nushell`, `herdr`, `stow`, and the existing Brewfile tools. |
| Omarchy | `omarchy pkg add` | Uses Omarchy's package workflow when available, preserving its package/config migration behavior. |
| Arch Linux | `pacman` | Uses the same package list as Omarchy. |
| Ubuntu/Debian | `apt` | Adds Nushell's official Gemfury APT repository; Herdr uses its official architecture-aware installer. |

Ubuntu's path intentionally installs CLI tools only, which keeps it suitable
for headless servers. Herdr can be launched locally over SSH, or attached from
another device with `herdr --remote <ssh-host>`.

## How linking works

GNU Stow is the only linker. The repository is treated as one package and
`--dotfiles` converts names such as `dot-config` and `dot-gitconfig` into
`.config` and `.gitconfig` under `$HOME`.

The installer uses `--restow --no-folding`:

- `--restow` makes rerunning the installer idempotent.
- `--no-folding` links individual files instead of whole directories, so
  runtime files such as Herdr logs and Nushell-generated autoload files are not
  written into this Git repository.
- `--adopt` is deliberately not used. Unmanaged conflicts are moved to
  `~/.dotfiles-backup/<timestamp>` before linking instead of being copied into
  the repository.

Nushell follows the XDG path on Linux (`~/.config/nushell`) but defaults to
`~/Library/Application Support/nushell` on macOS. Stow creates the XDG links;
the installer adds the two macOS links explicitly and backs up conflicting
macOS files under `~/.dotfiles-backup/<timestamp>/nushell`.

The retired tmux file remains in the repository as a migration reference and
is ignored by Stow. Existing managed zsh, Powerlevel10k, and tmux symlinks are
removed when the installer runs; unrelated user-owned files are left alone.
The installer also unfolds directory links created by older versions of this
repository. Links owned by another configuration (including an Omarchy
default) are backed up before the tracked file-level links are created.

## Nushell configuration

The shared config lives in `dot-config/nushell/config.nu`. It includes the old
Git, Docker, PHP, project-navigation, and Composer/Satis shortcuts translated
to native Nu commands. `PROJECTS` defaults to `~/Documents/Code` on macOS and
`~/Code` on Linux, but an inherited value wins.

Powerlevel10k itself is a zsh plugin and cannot run in Nushell. The existing
Oh My Posh theme is its cross-shell replacement: when `oh-my-posh` is
available, Nu loads `dot-config/oh-my-posh/mark.json` automatically. It retains
the path, Git state, language versions, exit status, execution time, clock,
secondary prompt, and transient prompt while using the same Nerd Font glyphs.
After installation, start a new `nu` session (or run `exec nu`) to activate the
prompt. The bootstrap installs Oh My Posh into `~/.local/bin`, which is included
in the tracked Nushell `PATH`.

Put private or machine-only Nu settings in the platform's Nushell config
directory as `local.nu`:

```nu
$env.MY_SECRET = "..."
$env.PROJECTS = ($env.HOME | path join "src")
```

`local.nu` is optional and is never linked or committed.

`local.nu` replaces the former `~/.secrets` hook and must contain Nushell
syntax. SSH-agent startup is deliberately not performed per shell; Nu inherits
`SSH_AUTH_SOCK` from a desktop session, login manager, or SSH connection when
an agent is in use.

The login banner is defined in `dot-config/nushell/login.nu` and appears for Nu
login shells. When running inside tmux, `config.nu` applies the former status
path and clock formatting.

## Herdr configuration

Herdr reads `~/.config/herdr/config.toml` on both Linux and macOS. The tracked
configuration selects Nu, keeps the old `Ctrl+A` prefix, and carries over the
familiar pane controls. Ghostty's former `Ctrl+A` split bindings are removed so
those keystrokes reach Herdr:

| Keys | Action |
| --- | --- |
| `Ctrl+A`, then `h/j/k/l` | Move between panes |
| `Ctrl+A`, then `v` | Split vertically |
| `Ctrl+A`, then `-` | Split horizontally |
| `Ctrl+A`, then `+` | Zoom/unzoom a pane |
| `Ctrl+A`, then `1`…`9` | Select a tab |

Run `herdr server reload-config` after editing the Herdr config. Run `config nu`
inside Nu to edit the active Nushell configuration.
