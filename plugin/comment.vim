let g:comment_config_path = '~/.vim/config/comment/config.json'

function! Comment(sym)
	let actual_sym = escape(a:sym, '/\.*$^~[]')
	let line_content = getline(".")
	if line_content =~ '^' . actual_sym
		if line_content =~ '^' . actual_sym . ' '
			execute "'<,'>s/^" . actual_sym . " //"
		else
			execute "'<,'>s/^" . actual_sym . "//"
 		endif
	else
  		execute "'<,'>s/^/". actual_sym . " /"
	endif
endfunction

function! LoadCommentConfig()
	let config_file = expand(g:comment_config_path)
	if filereadable(config_file)
		let json_content = join(readfile(config_file), '')
		return json_decode(json_content)
	else
		" Fallback if file doesn't exist
		return {'vim': '"'}
	endif
endfunction

let comment_map = LoadCommentConfig()

function! ToggleComment()
	let sym = get(g:comment_map, &filetype, '#')
	call Comment(sym)
endfunction

xnoremap <C-_> :<C-u>call ToggleComment()<ENTER>gv
nnoremap <C-_> v:<C-u>call ToggleComment()<ENTER>

command! CommentConfig execute "edit " g:comment_config_path

