local dashboard = require('dashboard')

dashboard.custom_header = {
'  MMMMMMMM               MMMMMMMM                                  ',
'  M::::::::M           M::::::::M                                  ',
'  M:::::::::M         M:::::::::M                                  ',
'  M::::::::::M       M::::::::::M   ooooooooooo xxxxxxx      xxxxxxx ',
'  M:::::::::::M     M:::::::::::M oo:::::::::::oox:::::x    x:::::x ',
'  M::::::M M::::M M::::M M::::::Mo:::::ooooo:::::o x:::::xx:::::x   ',
'  M::::::M  M::::M::::M  M::::::Mo::::o     o::::o  x::::::::::x    ',
'  M::::::M   M:::::::M   M::::::Mo::::o     o::::o   x::::::::x     ',
'  M::::::M    M:::::M    M::::::Mo::::o     o::::o   x::::::::x     ',
'  M::::::M     MMMMM     M::::::Mo::::o     o::::o  x::::::::::x    ',
'  M::::::M               M::::::Mo:::::ooooo:::::o x:::::xx:::::x   ',
'  M::::::M               M::::::M oo:::::::::::oox:::::x    x:::::x ',
'  MMMMMMMM               MMMMMMMM   ooooooooooo xxxxxxx      xxxxxxx ',
' ',
}

dashboard.custom_center = {
  { icon = '  ', desc = 'New file                       ', action = 'enew' },
  { icon = '  ', shortcut = 'Ctrl P', desc = 'Find file                 ', action = 'Telescope find_files' },
  { icon = '  ', shortcut = 'SPC SPC', desc = 'Recent files              ', action = 'Telescope oldfiles' },
  { icon = '  ', shortcut = 'SPC fg', desc = 'Find Word                 ', action = 'Telescope live_grep' },
}

dashboard.custom_footer = { '' }

vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#6272a4' })
vim.api.nvim_set_hl(0, 'DashboardCenter', { fg = '#f8f8f2' })
vim.api.nvim_set_hl(0, 'DashboardShortcut', { fg = '#bd93f9' })
vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#6272a4' })
