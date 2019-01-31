
set smartindent
set wrap

"noremap  <buffer> <silent> k gk
"noremap  <buffer> <silent> j gj
"noremap  <buffer> <silent> 0 g0
"noremap  <buffer> <silent> $ g$

set number

command LaTex execute "!latex %"1

map <F5> :LaTex<CR>
