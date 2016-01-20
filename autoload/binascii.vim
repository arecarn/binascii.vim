""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Original Author: Ryan Carney
" License: WTFPL
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let s:save_cpo = &cpo
set cpo&vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

" PUBLIC FUNCTIONS {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! binascii#bin_to_hex(bin) abort "{{{2
    let x = {
                \ "0000" : "0",
                \ "0001" : "1",
                \ "0010" : "2",
                \ "0011" : "3",
                \ "0100" : "4",
                \ "0101" : "5",
                \ "0110" : "6",
                \ "0111" : "7",
                \ "1000" : "8",
                \ "1001" : "9",
                \ "1010" : "a",
                \ "1011" : "b",
                \ "1100" : "c",
                \ "1101" : "d",
                \ "1110" : "e",
                \ "1111" : "f"
                \ }
    let result = ""
    let number = split(a:bin, '....\zs')
    for char in number
        let result .= x[char]
    endfor
    return result
endfunction "}}}2

function! binascii#hex_to_bin(number) abort "{{{2
    let x = {
                \ "0" : "0000",
                \ "1" : "0001",
                \ "2" : "0010",
                \ "3" : "0011",
                \ "4" : "0100",
                \ "5" : "0101",
                \ "6" : "0110",
                \ "7" : "0111",
                \ "8" : "1000",
                \ "9" : "1001",
                \ "a" : "1010",
                \ "b" : "1011",
                \ "c" : "1100",
                \ "d" : "1101",
                \ "e" : "1110",
                \ "f" : "1111"
                \ }
    let result = ""
    let number = split(a:number, '.\zs')
    for char in number
        let result .= x[char]
    endfor
    return result
endfunction "}}}2

function! binascii#hex_to_str(hex_str) abort "{{{2
    let separator = nr2char(getchar())
    let hex_str = substitute(a:hex_str, separator, "", "ge")

    let str = ""
    for i in range(len(hex_str)/2)
        let str .= nr2char("0x" . strpart(hex_str, i*2, 2))
    endfor
    return  str
endfunction "}}}2

function! binascii#str_to_hex(str) abort "{{{2
    let separator = nr2char(getchar())

    if separator == ""
        let separator = ""
    endif

    let hex_str = ""
    for i in range(len(a:str))

        if(i == len(a:str) - 1)
            let separator = ""
        endif

        let hex_str = hex_str . printf("%02x", char2nr(a:str[i])) . separator
    endfor

    return  toupper(hex_str)
endfunction "}}}2

function! binascii#bin_info(bin) abort "{{{2
    let hex = binascii#bin_to_hex(a:bin)
    let number = eval("0x" . hex)
    let char = nr2char(number)
    let bin = a:bin
    return printf("%d, 0x%02x, '%s' 0b%s", number, number, char, bin)
endfunction "}}}2

function! binascii#char_info(char) abort "{{{2
    let number = char2nr(a:char)
    let char = a:char
    let bin = binascii#hex_to_bin(printf("%02x", number))
    return printf("%d, 0x%02x, '%s', 0b%s", number, number, char, bin)
endfunction "}}}2

function! binascii#number_info(number) abort "{{{2
    let number = eval(a:number)
    let char = nr2char(number)
    let bin = binascii#hex_to_bin(printf("%02x", number))
    return printf("%d, 0x%02x, '%s', 0b%s", number, number, char, bin)
endfunction "}}}2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""{{{
let &cpo = s:save_cpo
unlet s:save_cpo
" vim:foldmethod=marker
" vim: textwidth=78
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""}}}
