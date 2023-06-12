" cogent's filetype file
augroup filetypedetect
    autocmd! BufRead,BufNewFile *.t          setfiletype perl
    autocmd! BufRead,BufNewFile *.txt        setfiletype text
    autocmd! BufRead,BufNewFile TODO         setfiletype text
    autocmd! BufRead,BufNewFile README       setfiletype text
    autocmd! BufRead,BufNewFile MANIFEST     setfiletype text
    autocmd! BufRead,BufNewFile svn-commit.* setfiletype svn
    autocmd! BufRead,BufNewFile */Code/Slashdot/slash/* call Geeknet_whitespace()
    autocmd! BufRead,BufNewFile *;*          setfiletype tt2html
    autocmd! BufRead,BufNewFile */Code/Slashdot/slashmob/* call Pivotal_whitespace()
    autocmd! BufRead,BufNewFile */eFab/* call Clearbuilt_whitespace()
augroup END
