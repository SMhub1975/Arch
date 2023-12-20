"set nu
"set relativenumber

filetype plugin on
syntax on 

autocmd VimLeave * call system("echo -n $'" . escape(getreg(), "'") . "' | xsel --input --clipboard")
