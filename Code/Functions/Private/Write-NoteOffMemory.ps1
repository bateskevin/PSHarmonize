Function Write-NoteOffMemory {
    param(
        [int[]]$MidiNote
    )

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    foreach($Note in $MidiNote){
        $Obj.Notes += $Note
    }

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\NoteOffMemory.json

}