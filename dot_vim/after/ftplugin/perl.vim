setlocal formatoptions=cqrl2  " good standard programming formatoptions
setlocal autoindent

setlocal textwidth=78

setlocal tabstop=4
setlocal expandtab
setlocal shiftwidth=4
"set shiftround  " Damian likes this but I don't

setlocal matchpairs+=<:>

" makes it super-hard to comment out blocks
setlocal indentkeys-=0#

" this gets overwritten by $VIMRUNTIME/ftplugin/perl.vim anyway:
setlocal comments=n:#,:#\ -
