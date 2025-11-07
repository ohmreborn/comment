this plugin is a key map command in vim
[demo-comment](doc/demo.gif)

## install
install for vim plug
```vim
Plug 'ohmreborn/comment'
```
if you want to load default config
```vim
Plug 'ohmreborn/comment', { 'do': './install.sh' }
```

* `:CommentConfig` to edit the comment syntax
then type
```json
{
    "yourfiletype": "comment syntax"
}
```
to know which filetype you can use
```vim
:echo &filetype
```
here is an example from this [sample-config.json](./sample-config.json)

## sample keymap
```vim
xnoremap <C-/> :<C-u>call ToggleComment()<ENTER>gv
nnoremap <C-/> v:<C-u>call ToggleComment()<ENTER>
```