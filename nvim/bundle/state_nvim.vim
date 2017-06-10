if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/garrett/repos/dotfiles/nvim/init.vim'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/garrett/repos/dotfiles/nvim/bundle'
let g:dein#_runtime_path = '/Users/garrett/repos/dotfiles/nvim/bundle/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/garrett/repos/dotfiles/nvim/bundle/.cache/init.vim'
let &runtimepath = '/Users/garrett/.config/nvim,/etc/xdg/nvim,/Users/garrett/.local/share/nvim/site,/usr/local/share/nvim/site,/Users/garrett/repos/dotfiles/nvim/bundle/swift,/Users/garrett/repos/dotfiles/nvim/bundle//repos/github.com/Shougo/dein.vim,/Users/garrett/repos/dotfiles/nvim/bundle/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.2.0/share/nvim/runtime,/Users/garrett/repos/dotfiles/nvim/bundle/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/garrett/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/garrett/.config/nvim/after,/Users/garrett/repos/dotfiles/nvim/bundle/repos/github.com/Shougo/dein.vim'
filetype off
