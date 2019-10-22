Function Update-MidiMemory {

    $JSON = Get-Content $PSScriptRoot\Facts\Memory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.0 = $Obj.1
    $Obj.1 = $Obj.2
    $Obj.2 = $Obj.3
    $Obj.3 = $Obj.4
    $Obj.4 = $Obj.5
    $Obj.5 = $Obj.6
    $Obj.6 = $Obj.7
    $Obj.7 = $Obj.8
    $Obj.8 = $Obj.9
    $Obj.9 = $Obj.10
    $Obj.10 = $Obj.11
    $Obj.11 = $Obj.12
    $Obj.12 = $Obj.13
    $Obj.13 = $Obj.14
    $Obj.14 = $Obj.15
    $Obj.15 = $Obj.16

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json

}