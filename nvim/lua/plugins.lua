local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Color scheme
  { import = 'plugin_config.tokyonight' },

  -- Commenting support.
  { 'tpope/vim-commentary' },

  -- Add, change, and delete surrounding text.
  { 'tpope/vim-surround' },

  -- Useful commands like :Rename and :SudoWrite.
  { 'tpope/vim-eunuch' },

  -- Pairs of handy bracket mappings, like [b and ]b.
  { 'tpope/vim-unimpaired' },

  -- Indent autodetection with editorconfig support.
  { 'tpope/vim-sleuth' },

  -- Allow plugin_config to enable repeating of commands.
  { 'tpope/vim-repeat' },

  -- Add more languages.
  -- { 'sheerun/vim-polyglot' },

  -- Navigate seamlessly between Vim windows and Tmux panes.
  { 'christoomey/vim-tmux-navigator' },

  -- Jump to the last location when opening a file.
  { 'farmergreg/vim-lastplace' },

  -- Enable * searching with visually selected text.
  { 'nelstrom/vim-visual-star-search' },

  -- Automatically create parent dirs when saving.
  { 'jessarcher/vim-heritage' },

  -- Text objects for HTML attributes.
  { 'whatyouhide/vim-textobj-xmlattr', dependencies = 'kana/vim-textobj-user'  },

  -- Automatically set the working directory to the project root.
  { import = 'plugin_config.vim-rooter' },

  -- Automatically add closing brackets, quotes, etc.
  { 'windwp/nvim-autopairs', config = true },

  -- Add smooth scrolling to avoid jarring jumps
  { 'karb94/neoscroll.nvim', config = true },

  -- All closing buffers without closing the split window.
  { import = 'plugin_config.bufdelete' },

  -- Split arrays and methods onto multiple lines, or join them back up.
  { import = 'plugin_config.splitjoin' },

  -- Automatically fix indentation when pasting code.
  { import = 'plugin_config.vim-pasta' },

  -- Fuzzy finder
  { import = 'plugin_config.telescope' },

  -- File tree sidebar
  { import = 'plugin_config.nvim-tree' },

  -- A Status line.
  { import = 'plugin_config.lualine' },

  -- Display buffers as tabs.
  { import = 'plugin_config.bufferline' },

  -- Display indentation lines.
  { import = 'plugin_config.indent-blankline' },

  -- Add a dashboard.
  { import = 'plugin_config.dashboard-nvim' },

  -- Git integration.
  { import = 'plugin_config.gitsigns' },

  -- Git commands.
  { 'tpope/vim-fugitive', dependencies = 'tpope/vim-rhubarb' },

  -- Floating terminal.
  { import = 'plugin_config.floaterm' },

  -- Improved syntax highlighting
  { import = 'plugin_config.treesitter' },

  -- Language Server Protocol.
  {  import = 'plugin_config.lspconfig' },

  -- Completion
  { import = 'plugin_config.cmp' },

  -- PHP Refactoring Tools
  { import = 'plugin_config.phpactor' },

  -- Project Configuration.
  { import = 'plugin_config.projectionist' },

  -- Testing helper
  { import = 'plugin_config.vim-test' },
})
