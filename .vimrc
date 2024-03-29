""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax on
set number
set mouse=a
set belloff=all
set splitbelow " Default is to split above
set wildmenu
set autochdir
set backspace=indent,eol,start
set shortmess=s
set cursorline
set cursorlineopt=number

if !has('nvim') " Enabled by default into neovim
    if has('mouse_sgr') | set ttymouse=sgr | else | set ttymouse=xterm2 | endif
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()
    Plug 'sainnhe/gruvbox-material'
    Plug 'junegunn/goyo.vim'
    Plug 'preservim/nerdtree'
    Plug 'TovarishFin/vim-solidity'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    if has('nvim')
    Plug 'kyazdani42/nvim-web-devicons'
    Plug 'kyazdani42/nvim-tree.lua'
    endif
call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colorscheme                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('termguicolors') | set termguicolors | endif

set background=dark

let g:gruvbox_material_background='hard' " soft|medium|hard
let g:gruvbox_material_palette='material' " material|mix|original

colorscheme gruvbox-material

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search                                                                       "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch
set incsearch
nnoremap <C-l> :nohlsearch<CR><C-l>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight (cf. https://vim.fandom.com/wiki/Highlight_unwanted_spaces)        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation                                                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

if (&filetype != 'make') | set expandtab | endif " make love tabs

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Terminal                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

tmap <silent> <A-Left>  <C-w>:wincmd h<CR>
tmap <silent> <A-Down>  <C-w>:wincmd j<CR>
tmap <silent> <A-Up>    <C-w>:wincmd k<CR>
tmap <silent> <A-Right> <C-w>:wincmd l<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup AutoSaveFolds
    if (bufname())
        autocmd!
        autocmd BufWinLeave * mkview
        autocmd BufWinEnter * silent! loadview
    endif
augroup END

" click to open/close fold
":noremap <2-LeftMouse> za

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Nerdtree                                                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !has('nvim')
    let NERDTreeSowHidden=1
    nnoremap <silent> t :NERDTreeToggle<Cr>
    autocmd FileType nerdtree noremap <silent> <buffer> t :NERDTreeToggle<Cr>
    " Exit Vim if NERDTree is the only window remaining in the only tab
    autocmd BufEnter * if (
                        \ tabpagenr('$') == 1
                        \ && winnr('$') == 1
                        \ && exists('b:NERDTree')
                        \ && b:NERDTree.isTabTree())
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc.nvim (cf. https://github.com/neoclide/coc.nvim)                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Goto code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" fzf                                                                          "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"let g:fzf_layout = { 'right' : '40%' }
"let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'relative': v:true } }

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" xclip                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

:cabbrev xclip w !xclip -selection clipboard

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spell                                                                        "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

highlight clear SpellBad
highlight clear SpellCap
highlight clear SpellRare
highlight clear SpellLocal

highlight SpellBad   cterm=underline ctermfg=red
highlight SpellCap   cterm=underline ctermfg=lightblue
highlight SpellRare  cterm=underline ctermfg=lightgreen
highlight SpellLocal cterm=underline ctermfg=lightyellow

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Windows                                                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <silent> <A-h>     :wincmd h<Cr>
nnoremap <silent> <A-j>     :wincmd j<Cr>
nnoremap <silent> <A-k>     :wincmd k<Cr>
nnoremap <silent> <A-l>     :wincmd l<Cr>
nnoremap <silent> <A-Left>  :wincmd h<Cr>
nnoremap <silent> <A-Down>  :wincmd j<Cr>
nnoremap <silent> <A-Up>    :wincmd k<Cr>
nnoremap <silent> <A-Right> :wincmd l<Cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
