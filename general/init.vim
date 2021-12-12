let g:nerdtreeshowhidden = 1
let g:nerdtreeminimalui = 1
let g:nerdtreeignore = []
let g:nerdtreestatusline = ''
" automaticaly close nvim if nerdtree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:nerdtree") && b:nerdtree.istabtree()) | q | endif
" toggle
nnoremap <silent> <c-b> :nerdtreetoggle<cr>

" use alt+hjkl to move between split/vsplit panels
tnoremap <a-h> <c-\><c-n><c-w>h
tnoremap <a-j> <c-\><c-n><c-w>j
tnoremap <a-k> <c-\><c-n><c-w>k
tnoremap <a-l> <c-\><c-n><c-w>l
nnoremap <a-h> <c-w>h
nnoremap <a-j> <c-w>j
nnoremap <a-k> <c-w>k
nnoremap <a-l> <c-w>l
