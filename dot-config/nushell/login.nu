# This file runs for Nushell login sessions. Shared environment setup belongs
# in config.nu so regular Nu and Herdr sessions behave identically.

let host = (sys host)
let memory = (sys mem)
let root_disk = (sys disks | where mount == / | get 0?)
let memory_usage = $"($memory.used | format filesize GB)/($memory.total | format filesize GB)"
let disk_usage = if ($root_disk | is-empty) {
    "unavailable"
} else {
    $"(($root_disk.total - $root_disk.free) | format filesize GB)/($root_disk.total | format filesize GB)"
}
let banner = $"
MMMMMMMM               MMMMMMMM
M:::::::M             M:::::::M
M::::::::M           M::::::::M
M:::::::::M         M:::::::::M
M::::::::::M       M::::::::::M   ooooooooooo xxxxxxx      xxxxxxx
M:::::::::::M     M:::::::::::M oo:::::::::::oox:::::x    x:::::x
M:::::::M::::M   M::::M:::::::Mo:::::::::::::::ox:::::x  x:::::x
M::::::M M::::M M::::M M::::::Mo:::::ooooo:::::o x:::::xx:::::x
M::::::M  M::::M::::M  M::::::Mo::::o     o::::o  x::::::::::x
M::::::M   M:::::::M   M::::::Mo::::o     o::::o   x::::::::x
M::::::M    M:::::M    M::::::Mo::::o     o::::o   x::::::::x
M::::::M     MMMMM     M::::::Mo::::o     o::::o  x::::::::::x
M::::::M               M::::::Mo:::::ooooo:::::o x:::::xx:::::x
M::::::M               M::::::Mo:::::::::::::::ox:::::x  x:::::x
M::::::M               M::::::M oo:::::::::::oox:::::x    x:::::x
MMMMMMMM               MMMMMMMM   ooooooooooo xxxxxxx      xxxxxxx

($host.long_os_version)
Disk ($disk_usage)  Memory ($memory_usage)  Uptime ($host.uptime)

Greetings Mark, welcome back!
"

if (which lolcat | is-not-empty) {
    $banner | ^lolcat
} else {
    print $banner
}
