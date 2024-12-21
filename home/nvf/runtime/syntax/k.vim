if exists('b:current_syntax')|fini|en|sy clear|sy case match |sy sync fromstart |if&l:syn==#'k'|setl com=:/ isk=a-z,A-Z,48-57|en
sy match  k_e  /\k\+\|\S/
sy match  k_s  /\c`\([a-zа-яё][a-zа-яё0-9]*\)\=/                nextgroup=@k_vw                         |hi link k_s       constant
sy match  k_w  /[\\\/']:\=/                                     nextgroup=k_w   contained               |hi link k_w       operator
sy match  k_c1 /.\+/                                                            contained               |hi link k_c1      special
sy match  k_c0 /\\\(\w\+\|\\\|$\)/                              nextgroup=k_c1                          |hi link k_c0      statement
sy match  k_c0 /\\[tw]\>\(:\d\+\)\=/
sy match  k_e  /"/                                              nextgroup=k_es                          |hi link k_e       error
sy match  k_es /.*/                                             nextgroup=@k_vw contained               |hi link k_es      k_string
sy match  k_string /"\(\\.\|[^"\n]\)*"/                         nextgroup=@k_vw contains=k_q            |hi link k_string  string
sy match  k_q  /\\./                                                            contained               |hi link k_q       specialchar
sy match  k_u  /[+\-*%!&|<>=~,^#_$?@.\x80-\U000fffff:]:\=/      nextgroup=k_w                           |hi link k_u       function
sy match  k_v  /[+\-*%!&|<>=~,^#_$?@.\x80-\U000fffff]:\=/       nextgroup=k_w   contained               |hi link k_v       type
sy match  k_n  /\v-=\d+([bNnwf]|(\.\d+)=(e-=\d+)=)=/            nextgroup=@k_vw                         |hi link k_n       number
sy match  k_i  /\c[a-zа-яё][a-zа-яё0-9]*\(\.[a-zа-яё][a-zа-яё0-9]*\)*/ nextgroup=@k_vw                  |hi link k_i       variable
sy match  k_x  /\<[oxyz]\>/                                     nextgroup=@k_vw                         |hi link k_x       special
sy match  k_string /\<0x\(\x\x\)*\>/                            nextgroup=@k_vw
sy match  k_u  /\d::\=/                                         nextgroup=k_w
sy match  k_v  /\s*\d::\=/                                      nextgroup=k_w   contained
sy match  k_g  /:/                                                                                      |hi link k_g       statement
sy region k_ar matchgroup=k_a start=/(/                 end=/)/ nextgroup=@k_vw contains=@k_k,k_aj,k_ae |hi link k_a       nontext
sy region k_br matchgroup=k_b start=/\[/                end=/]/ nextgroup=@k_vw contains=@k_k,k_bj,k_be |hi link k_b       k_a
sy region k_cr matchgroup=k_c start=/{\(\[[^\]]*\]\)\=/ end=/}/ nextgroup=@k_vw contains=@k_k,k_cj,k_ce |hi link k_c       special
sy region k_dr matchgroup=k_d start=/[\$:]\[/           end=/]/ nextgroup=@k_vw contains=@k_k,k_dj,k_be |hi link k_d       conditional
sy match  k_ae /[]}]/                                                           contained               |hi link k_ae      k_e
sy match  k_be /[})]/                                                           contained               |hi link k_be      k_e
sy match  k_ce /[)]]/                                                           contained               |hi link k_ce      k_e
sy match  k_aj /;/                                                              contained               |hi link k_aj      k_a
sy match  k_bj /;/                                                              contained               |hi link k_bj      k_b
sy match  k_cj /;/                                                                                      |hi link k_cj      k_c
sy match  k_dj /;/                                                                                      |hi link k_dj      k_d
sy match  k_t  / \\/                                                                                    |hi link k_t       k_u
sy match  k_comment /^#!.*/                                                                             |hi link k_comment comment
sy match  k_comment /^\/.*/
sy match  k_comment / \+\/.*/
sy region k_comment matchgroup=k_comment start=/^\/$/   end=/^\\$/
sy region k_comment matchgroup=k_comment start=/^\\\\$/ end=/^\%$/
sy cluster k_vw contains=k_v,k_w
sy cluster k_k  contains=k_e,k_s,k_u,k_w,k_c0,k_i,k_x,k_comment,k_n,k_string,k_g,k_ar,k_br,k_cr,k_dr,k_t
let b:current_syntax='k'
