colorscheme vinimal

set tabstop=2
set shiftwidth=2
set expandtab

set noswapfile

let mapleader=' '

nnoremap ; :
nnoremap Q @@

" completions
set complete=.,w,b,u,t,i
set completeopt=menu,noinsert
inoremap <A-Space> <C-x><C-o>

" never enough methods to quit
nnoremap <leader>x :x<CR>
nnoremap <leader>X :cq<CR>

" disable yank when pasting in visual mode
vnoremap p "_dP

" window commands
" no ctrl
nnoremap <leader>w <C-w>
" resize vertical
nnoremap <leader>- :exe "vertical resize -20"<CR>
nnoremap <leader>= :exe "vertical resize +20"<CR>

" search/replace
" word under cursor
nnoremap <leader>/ yiw:%s/<C-r>"/<C-r>"
" visual selection
vnoremap <leader>/ y:%s/<C-r>"/<C-r>"

" compile
" with Makefile
nnoremap <leader>m :!make<CR>
" without Makefile [file].c => [file]
nnoremap <leader>M :!gcc -g -o %:r %<CR>

" debugger
packadd termdebug
let g:termdebug_wide=1
nnoremap <leader>dd :Termdebug<CR>
nnoremap <leader>df :Termdebug ./%:r<CR>
nnoremap <leader>dr :Run<CR>
nnoremap <leader>b :Break<CR>
nnoremap <leader>B :Clear<CR>
nnoremap <leader>s :Step<CR>
nnoremap <leader>n :Over<CR>
nnoremap <leader>N :Continue<CR>
nnoremap <leader>v :Evaluate<CR>
nnoremap <leader>dx :call TermDebugSendCommand("exit")<CR>

" fzf.vi
" Debian
source /usr/share/doc/fzf/examples/fzf.vim
" Arch
" source /usr/share/vim/vimfiles/plugin/fzf.vim
nnoremap <C-p> :Files<CR>

lua require('config')
