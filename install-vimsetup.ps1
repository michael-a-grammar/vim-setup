function Main {
    . Functions

    $localVimrcPath      = Get-LocalVimrcPath
    $localVimRuntimePath = Get-LocalVimRuntimePath
}

function Functions {
    function Get-LocalVimrcPath {
        Get-ItemFullName -ItemPath ./.vimrc
    }

    function GetLocalVimRuntimePath {
        Get-ItemFullName -ItemPath ./.vim
    }

    function Get-InstalledVimrcPath {
        if ($IsWindows) {
            "$env:LOCALAPPDATA/nvim/init.vim"
        } elseif ($IsMacOS) {
            "~/.config/nvim/init.vim"
        }
    }

    function Get-ItemFullName {
        param (
            $ItemPath
        )

        Get-Item -Path $ItemPath -Force | Select-Object -Expand FullName | Write-Output
    }

    function Test-Command {
        param (
            $Name
        )

        Get-Command -Name $Name -ErrorAction Ignore
    }

    function New-SymbolicLink {
        param (
            $Target,
            $Path
        )

        New-Item -ItemType SymbolicLink -Target $Target -Path $Path
    }
}

Main
