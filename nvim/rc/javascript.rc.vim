function! EnableJavascript()
  " Setup used libraries
  let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,d3'
  let b:javascript_lib_use_jquery = 1
  let b:javascript_lib_use_underscore = 1
  let b:javascript_lib_use_react = 1
  let b:javascript_lib_use_flux = 1
  let b:javascript_lib_use_jasmine = 1
  let b:javascript_lib_use_d3 = 1
endfunction
autocmd MyVimrc FileType javascript,javascript.jsx call EnableJavascript()

" ale status
let g:ale_linters = {
  'javascript' : ['eslint'],
}
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}
"let g:ale_statusline_format = 'E'
let g:ale_echo_mgs_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter] %s [%severity%] [%...code...%]'

