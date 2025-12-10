return {
  'lukas-reineke/indent-blankline.nvim',
  main = "ibl",
  opts = {
    exclude = {
      filetypes = {
        'help',
        'terminal',
        'dashboard',
        'lspinfo',
        'TelescopePrompt',
        'TelescopeResults',
      },
      buftypes = {
        'terminal',
        'NvimTree',
      },
    },
  }
}
