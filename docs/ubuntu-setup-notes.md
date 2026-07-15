# Ubuntu/Debian server notes

The root `./install` script handles these systems. It installs the CLI package
set, adds Nushell's signed Gemfury repository, installs Herdr with the official
Linux installer, and then applies the shared Stow links.

Keep the account's POSIX login shell while using Nu in Herdr:

```sh
./install
herdr
```

From a workstation with Herdr installed, a server can also be attached through
its existing SSH configuration:

```sh
herdr --remote my-server
```
