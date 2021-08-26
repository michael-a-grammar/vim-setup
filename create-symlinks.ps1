function Main {
    $path = Get-Item -Path .\.vimrc | Select-Object -Expand FullName

    New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\nvim\init.vim" -Target $path
}

. Main

