if exists('g:loaded_task') | finish | endif

let s:save_cpo = &cpo
set cpo&vim



command! -nargs=1 Task lua require'task'.task_command(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_task = 1


