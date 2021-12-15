open System
open System.IO

type OS =
    | Windows
    | MacOs
    | Unix

let os =
    Environment.OSVersion.Platform
    |> function
        | PlatformID.Win32S
        | PlatformID.Win32Windows
        | PlatformID.Win32NT -> Some Windows
        | PlatformID.MacOSX -> Some MacOs
        | PlatformID.Unix -> Some Unix
        | _ -> None

type DirectoryExistsResult =
    | DirectoryExists of string
    | DirectoryDoesNotExist of string

let directoryExists path =
    path
    |> Directory.Exists
    |> function
        | true -> DirectoryExists path
        | false -> DirectoryDoesNotExist path

type FileExistsResult =
    | FileExists of string
    | FileDoesNotExist of string

let fileExists path =
    path
    |> File.Exists
    |> function
        | true -> FileExists path
        | false -> FileDoesNotExist path

let getLocalFilePath =
    let currentDirectory = Directory.GetCurrentDirectory()

    fun filePath ->
        (currentDirectory, filePath)
        |> Path.Combine
        |> fileExists

type CreateSymbolicLinkResult =
    | Success of FileSystemInfo
    | SymbolicLinkPathExists of string
    | TargetPathDoesNotExist of string
    | IOError of (IOException * string * string)
    | InvalidArguments of (string * string)

let createSymbolicLink symbolicLinkPath targetPath =
    (symbolicLinkPath, targetPath)
    |> function
        | FileDoesNotExist symbolicLinkPath, FileExists targetPath ->
            try
                File.CreateSymbolicLink(symbolicLinkPath, targetPath)
                |> Success
            with
            | :? IOException as ex -> IOError(ex, symbolicLinkPath, targetPath)
            | _ -> InvalidArguments(symbolicLinkPath, targetPath)
        | FileExists symbolicLinkPath, _ -> SymbolicLinkPathExists symbolicLinkPath
        | _, FileDoesNotExist targetPath -> TargetPathDoesNotExist targetPath

let getLocalVimProfilePath () = getLocalFilePath "profile.vim"

type EnvironmentError =
    | OSNotMapped
    | ConfigurationDirectoryEnvironmentVariableNotFound of string

type GetVimDirectoryResult =
    | VimDirectoryExistsResult of DirectoryExistsResult
    | EnvironmentError of EnvironmentError

let getVimDirectory os =
    os
    |> function
        | Some Windows -> Some "LocalAppData"
        | Some Unix
        | Some MacOs -> Some "XDG_CONFIG_HOME"
        | None -> None
    |> function
        | Some variable ->
            variable
            |> Environment.GetEnvironmentVariable
            |> function
                | path when not (String.IsNullOrWhiteSpace path) -> Some path
                | _ -> None
            |> function
                | Some path ->
                    (path, "nvim")
                    |> Path.Combine
                    |> directoryExists
                    |> VimDirectoryExistsResult
                | None ->
                    variable
                    |> ConfigurationDirectoryEnvironmentVariableNotFound
                    |> EnvironmentError
        | None -> EnvironmentError OSNotMapped

type GetSymbolicLinkPathResult =
    | SymbolicLinkPathExistsResult of FileExistsResult
    | VimDirectoryDoesNotExist of string
    | EnvironmentError of EnvironmentError

let getVimFileSymbolicLinkPath getVimDirectoryResult filePath =
    getVimDirectoryResult
    |> function
        | VimDirectoryExistsResult directoryExistsResult ->
            directoryExistsResult
            |> function
                | DirectoryExists directory ->
                    (directory, filePath)
                    |> Path.Combine
                    |> fileExists
                    |> SymbolicLinkPathExistsResult
                | DirectoryDoesNotExist directory -> VimDirectoryDoesNotExist directory
        | GetVimDirectoryResult.EnvironmentError environmentError -> EnvironmentError environmentError

type CreateVimFileSymbolicLinkResult =
    | CreateSymbolicLinkResult of CreateSymbolicLinkResult
    | GetSymbolicLinkPathResult of GetSymbolicLinkPathResult

let createVimFileSymbolicLink filePath =
    let vimDirectory = getVimDirectory os
    let targetPath = getLocalVimProfilePath ()

    printfn $"Vim directory: %A{vimDirectory}"
    printfn $"Target path: %A{targetPath}"

    let symbolicLinkPath =
        getVimFileSymbolicLinkPath vimDirectory filePath

    printfn $"Symbolic link path: %A{symbolicLinkPath}"

    symbolicLinkPath
    |> function
        | SymbolicLinkPathExistsResult symbolicLinkPath ->
            (symbolicLinkPath, targetPath)
            ||> createSymbolicLink
            |> CreateSymbolicLinkResult
        | _ -> symbolicLinkPath |> GetSymbolicLinkPathResult

let createVimProfileSymbolicLink () = createVimFileSymbolicLink "init.vim"

let result = createVimProfileSymbolicLink ()

printfn $"%A{result}"
