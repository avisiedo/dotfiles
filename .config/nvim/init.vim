" Run: nvim -c PlugInstall -c q -c q --headless

" Set the leader key
let mapleader = " "

" Set the tab size and indentation
set expandtab
set shiftwidth=4
set tabstop=4

" Enable syntax highlighting
syntax on

" Enable auto-indentation
set autoindent
set smartindent

" Set the encoding
set encoding=utf-8

" Set the file types
autocmd FileType go setlocal tabstop=4 shiftwidth=4 expandtab

" see: https://github.com/rockerBOO/awesome-neovim?tab=readme-ov-file
" Install plugins using vim-plug
" Run: nvim -c PlugInstall -c q -c q --headless
call plug#begin()
" Colorschema plugins
Plug 'ellisonleao/gruvbox.nvim'

" Tree explorer
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

Plug 'nvim-tree/nvim-web-devicons'
Plug 'antosha417/nvim-lsp-file-operations'

Plug 'nvim-neo-tree/neo-tree.nvim'

" keybinding
Plug 'folke/which-key.nvim'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Plug 'kien/ctrlp.vim'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Configure Tree Explorer keymaps
nmap <C-t> :Neotree filesystem reveal left toggle<cr>

" Configure vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_term_enabled = 1

" Set colorscheme
" https://github.com/ellisonleao/gruvbox.nvim?tab=readme-ov-file#basic-usage
set background=dark
colorscheme gruvbox

set hidden
set signcolumn=yes:2
set relativenumber
set number
set termguicolors
set undofile
set spell
set title
set ignorecase
set smartcase
set wildmode=longest:full,full
set nowrap
set list
set mouse=a
set scrolloff=8
set sidescrolloff=8
set nojoinspaces
set splitright
set clipboard=unnamedplus
set confirm
set exrc

set updatetime=300
set shortmess+=c

" Use <c-space> to trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" Fuzzy search
" https://github.com/junegunn/fzf.vim
let g:fzf_vim = {}
let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']

let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset': 0.5, 'xoffset': 0.5 } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" Customize the Files command to use rg which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles variation that ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

nmap <leader>f :Files<cr>
nmap <leader>F :AllFiles<cr>
nmap <leader>b :Buffers<cr>
nmap <leader>h :History<cr>
nmap <leader>r :Rg<cr>
nmap <leader>R :Rg<space>
nmap <leader>gb :GBranches<cr>

" Custom remaps
" nnoremap   <silent>   <F7>    :FloatermNew<CR>

" Set cursorliine
set cursorline
set hlsearch
set cursorcolumn

" Wild menu
set wildmenu
set wildmode=full
set cmdheight=0

" vim-go mappings
autocmd FileType go nmap <buffer> <F5> <plug>(go-run)

" Width column
set colorcolumn=50,72,80
highlight ColorColumn ctermbg=black guibg=#333333

