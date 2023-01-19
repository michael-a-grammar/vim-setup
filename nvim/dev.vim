set runtimepath-=~/.config/nvim
set runtimepath+=~/dev/milque/vim-setup/nvim

lua << EOF
  require('dev')
EOF
