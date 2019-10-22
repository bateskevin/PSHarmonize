Function Write-MidiNoteOff {

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    foreach($Note in $Obj.Notes){
        $ReturnString = @'
Send-MidiNoteOffMessage -Note {0} -Velocity 10 -Channel 0 -Port $Port
'@ -f $Note
    
    $ReturnString | Out-File -FilePath $CurrentSong -Append
}
}