#r "nuget: Microsoft.Management.Infrastructure, 2.0.0.0"
#r "nuget: Microsoft.PowerShell.SDK, 7.1.5"

open System
open System.IO
open System.Management.Automation

type OS =
    | Windows
    | MacOs
    | Unix

let currentDirectory = Directory.GetCurrentDirectory()

let localVimProfilePath =
    let localVimProfilePath = $"{currentDirectory}/profile.vim"

    match File.Exists(localVimProfilePath) with
    | true -> Some localVimProfilePath
    | _ -> None

let os =
    match Environment.OSVersion.Platform with
    | PlatformID.Win32S
    | PlatformID.Win32Windows
    | PlatformID.Win32NT -> Some Windows
    | PlatformID.MacOSX -> Some MacOs
    | PlatformID.Unix -> Some Unix
    | _ -> None

let getVimProfilePath os =
    match os with
    | Some Windows ->
        Environment.GetEnvironmentVariable("LocalAppData")
        |> Some
    | Some Unix
    | Some MacOs -> Some "~/.config"
    | _ -> None
    |> function
        | Some value -> Some $"{value}/nvim/init.vim"
        | _ -> None

os
|> getVimProfilePath
|> function
    | Some value -> printfn $"%A{value}"
    | _ -> printf "Failed"

localVimProfilePath
|> function
    | Some value -> printfn $"%A{value}"
    | _ -> printfn "Failed with local vim profile path"

let ps =
    async {
        use ps = PowerShell.Create()
        ps.AddScript("ls") |> ignore
        let! items = ps.InvokeAsync() |> Async.AwaitTask
        printfn $"%A{items}"
    }

ps |> Async.RunSynchronously