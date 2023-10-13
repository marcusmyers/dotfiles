return {
  'glepnir/dashboard-nvim',
  opts = {
    theme = 'doom',
    config = {
      header = {
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
      },
      center = {
        { icon = '  ', desc = 'New file                       ', action = 'enew' },
        { icon = '  ', key = 'Ctrl P', desc = 'Find file                 ', action = 'Telescope find_files' },
        { icon = '  ', key = 'SPC SPC', desc = 'Recent files              ', action = 'Telescope oldfiles' },
        { icon = '  ', key = 'SPC fg', desc = 'Find Word                 ', action = 'Telescope live_grep' },
      },
      footer = { '' },
    },
    hide = {
      statusline = false,
      tabline = false,
      winbar = false,
    }
  },
  init = function()
    vim.api.nvim_set_hl(0, 'DashboardHeader', { fg = '#6272a4' })
    vim.api.nvim_set_hl(0, 'DashboardDesc', { fg = '#f8f8f2' })
    vim.api.nvim_set_hl(0, 'DashboardIcon', { fg = '#bd93f9' })
    vim.api.nvim_set_hl(0, 'DashboardKey', { fg = '#6272a4' })
    vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#6272a4' })
  end
}
