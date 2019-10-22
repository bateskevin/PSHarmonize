Function Write-MidiMemory {
    param(
        $MidiNote,
        $Length
    )

    Switch ($Length) {
        "Semibreve" {$NoteLength = 16}
        "Minim" {$NoteLength = 8}
        "Crotchet" {$NoteLength = 4}
        "Quaver" {$NoteLength = 2}
        "Semiquaver" {$NoteLength = 1}
    }
 
    $JSON = Get-Content $PSScriptRoot\Facts\Memory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.$NoteLength += $MidiNote

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json

}