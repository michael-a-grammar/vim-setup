set runtimepath-=~/.config/nvim
set runtimepath+=~/dev/milque/vim-setup

lua << EOF
  require('dev.lua')
EOF
