" Ptolemarch's filetype file
"-- CircuitPython -----------------------------------------------------------
function CircuitPython ()
endfunction

"-- Work whitespace ---------------------------------------------------------
function Geeknet_whitespace ()
    setlocal tabstop=8
    setlocal shiftwidth=8
    setlocal noexpandtab
endfunction

function Pivotal_whitespace ()
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal expandtab
endfunction

function Clearbuilt_whitespace ()
    setlocal tabstop=3
    setlocal shiftwidth=3
    setlocal expandtab
endfunction

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
    autocmd! BufRead,BufNewFile /mnt/cp/* call CircuitPython()
augroup END
