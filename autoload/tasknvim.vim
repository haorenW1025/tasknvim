function! tasknvim#term_exit(job_id, code, event) dict
    if a:code == 0
        echom "task success!"
        if s:autoclose == "true"
            exec printf('%dclose!', s:winID)
            exec printf('%dbdelete!', s:bufID)
        endif
    else
        echohl WarningMsg | echom "task error!" | echohl None
    endif
    " let s:buifID = 0
endfunction

function! tasknvim#toggle_term(cmd, winID, bufID, autoclose)
    let s:winID = a:winID
    let s:bufID = a:bufID
    let s:autoclose = a:autoclose
    call termopen(a:cmd, {'on_exit': function('tasknvim#term_exit')})
endfunction

function! tasknvim#toggle_quickfix(cmd, bufID)
    echom a:bufID
    call termopen(a:cmd, {'on_exit': function('tasknvim#term_exit')})
endfunction
