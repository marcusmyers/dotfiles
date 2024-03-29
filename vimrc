set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Load Plugins
if filereadable(expand("~/.dotfiles/vim/vim-base-plugins"))
  source $HOME/.dotfiles/vim/vim-base-plugins
endif

syntax on

" Wrap gitcommit file types at the appropriate length
filetype indent plugin on

" Add airline setup
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline_powerline_fonts = 1

let g:python3_host_prog = '/usr/bin/python'
" Set theme
let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme solarized
"let g:solarized_termtrans = 1

" Global tab width.
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_left_sep = "\ue0b0"
let g:airline_right_sep = "\ue0b2"

" Set to show invisibles (tabs & trailing spaces) & their highlight color
set list listchars=tab:»\ ,trail:·

set number
set ruler
set showmode
" Handle multiple buffers better
set hidden
" Enhanced command line completion.
set wildmenu
" Complete files like a shell.
set wildmode=list:longest
" Highlight matches as you type.
set incsearch
" Highlight matches.

set hlsearch
" Case-insensitive searching.
set ignorecase
" But case-sensitive if expression contains a capital letter.
set smartcase

" Turn on line wrapping.
set wrap
" Show 3 lines of context around the cursor.
set scrolloff=3

" Set the terminal's title
set title

" No beeping.
set visualbell

" Clear search results
nnoremap ,<space> :noh<cr>

"-----------Splits--------------"

" Navigating splits
nnoremap <leader>w <C-w>v<C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Turn off auto-indention
map ni :set invai<cr>

" Configure spell checking
nmap <silent> <leader>p :set spell!<CR>
set spelllang=en_us

" Add spaces after comment delimiters in NERDCommenter. This makes the
" " following code:
" "
" "   if something
" "     do_great!
" "   end
" "
" " Look like this when commented:
" "
" "   # if something
" "   #  do_great!
" "   # end
let g:NERDSpaceDelims=1

set guioptions-='r'

" Map nerd tree
map <C-n> :NERDTreeToggle<CR>

"-----------Laravel-Commands------------"

nnoremap <leader>lr :e app/Http/routes.php<cr>
nnoremap <leader>lm :!php artisan make:

" Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in ‘runtimepath’
syntax on
filetype plugin indent on

"-------------Auto-Commands--------------"

"Automatically source the Vimrc file on save.
augroup autosourcing
  autocmd!
  autocmd BufWritePost .vimrc source %
augroup END
