Function Clear-NoteOffMemory {

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.Notes = @()    
    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\NoteOffMemory.json

}