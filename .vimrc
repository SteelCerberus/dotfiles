" --- General Settings ---
let mapleader = " "
let maplocalleader = " "
let g:have_nerd_font = 1

" Jump to last known position on BufReadPost
augroup LastPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END

" --- Syntax ---
syntax on

" --- Options ---
set termguicolors
set number
set mouse=a
set showmode
set clipboard=unnamedplus
set undofile

" Searching
set ignorecase
set incsearch
set smartcase

" Indenting
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4

" UI
set signcolumn=no
set list
set listchars=tab:\ \ ,trail:·,nbsp:␣
set fillchars=eob:\ 

" --- Keymaps ---

" Move cursor based on physical lines
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
vnoremap <expr> j v:count == 0 ? 'gj' : 'j'
vnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap ^ g^
nnoremap 0 g0

" Remap escape
inoremap jj <Esc>
inoremap jk <Esc>

" Typing ` is harder than typing ', and ` is more useful
nnoremap ' ``

" Insert semicolon at end of line
inoremap ;; <Esc>mzA;<Esc>``za

" Enter creates new line below
nnoremap <CR> :call append(line('.'), repeat([''], v:count1))<CR>
" Shift + Enter as insert new line above
nnoremap <S-CR> :call append(line('.') - 1, repeat([''], v:count1))<CR>

" Natural end of line
nnoremap $ g_

" Space space to insert a space in normal mode
nnoremap <leader><leader> a <Esc>h

" Keeps visual selected when indenting
vnoremap < <gv
vnoremap > >gv

" Clear highlights on search
nnoremap <Esc> :nohlsearch<CR>

" Toggle spellcheck
nnoremap <F11> :set spell!<CR>
inoremap <F11> <C-o>:set spell!<CR>

" Change text without putting it into the vim register
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
vnoremap c "_c

" Select the just pasted text
nnoremap gp \`[v\`]

" Window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Window resizing
nnoremap <C-s-l> :vertical resize +3<CR>
nnoremap <C-s-h> :vertical resize -3<CR>
nnoremap <C-s-j> :resize +3<CR>
nnoremap <C-s-k> :resize -3<CR>

" Remove trailing whitespace characters
nnoremap <leader>wt :%s/\s\+$//e<CR>

" Copy absolute path of current buffer
nnoremap <Leader>c :call setreg('+', expand('%:p'))<CR>
nnoremap <C-c> :call setreg('+', expand('%:p'))<CR>
