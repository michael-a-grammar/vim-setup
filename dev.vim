set runtimepath-=~/.config/nvim
set runtimepath+=~/dev/milque/vim-setup

lua << EOF
  print('here')
  require('init')
EOF
