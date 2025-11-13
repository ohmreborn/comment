let g:comment_config_path = '~/.vim/config/comment/config.json'

function! Comment(sym)
	let actual_sym = escape(a:sym, '/\.*$^~[]')
	" check is all comment?
	let result = execute("'<,'>s/^" . actual_sym . "//gne")
	" match digit
	let num_comment = matchstr(result, '\d\+') 
	let num_comment = num_comment ? num_comment : 0
	let start_line = line("'<")
	let end_line = line("'>")
	let num_select = end_line - start_line + 1

	if num_comment == num_select
		" uncomment
		execute "'<,'>s/^" . actual_sym . " //"
	else
		" comment
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
	let sym = g:comment_map[&filetype]
	call Comment(sym)
endfunction

command! CommentConfig execute "edit " g:comment_config_path

