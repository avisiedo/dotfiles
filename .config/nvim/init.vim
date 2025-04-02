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

" Configure NERDTree
" https://github.com/preservim/nerdtree?tab=readme-ov-file#frequently-asked-questions
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>
" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | call feedkeys(":quit\<CR>:\<BS>") | endif

" Install plugins using vim-plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree'
Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Configure vim-go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_term_enabled = 1

" Set colorscheme
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



let g:fzf_layout = { 'up': '~90%', 'window': { 'width': 0.8, 'height': 0.8, 'yoffset': 0.5, 'xoffset': 0.5 } }
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

" Customise the Files command to use rg which respects .gitignore files
command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))

" Add an AllFiles variation that ignores .gitignore files
command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))

" nnoremap <leader> :map <leader>
" nnoremap <silent> <leader> :redir =>m<CR>:silent map <leader><CR>:redir END<CR>:new<CR>:put! =m<CR>
nnoremap <leader> :lua require('utils').show_leader_keys()<CR>

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
set cmdheight=2

" vim-go mappings
autocmd FileType go nmap <buffer> <F5> <plug>(go-run)

