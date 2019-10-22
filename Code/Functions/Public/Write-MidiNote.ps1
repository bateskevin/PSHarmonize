Function Write-MidiNote {
    param(
        [Note[]]$Note,
        $Length,
        $Velocity
    )

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    $MidiJSON = (Get-Content $ModulePath\Facts\MidiMapping.json)
    $MidiObj = $MidiJSON | ConvertFrom-Json

    if($Note.count -gt 1){
        
    Foreach($Instance in $Note){
        $MidiNote = ($MidiObj | Where-Object {$_.letter -eq $Instance.Letter -and $_.Octave -eq $Instance.Octave}).MidiMapping 
        $ReturnString = @'
Send-MidiNoteOnMessage -Note {0} -Velocity 100 -Channel 0 -Port $Port
'@ -f $MidiNote

    $ReturnString | Out-File -FilePath $CurrentSong -Append

    $CurrentTime = Get-CurrentTime
    Write-MidiMemory -MidiNote $MidiNote -Length $CurrentTime
    Write-NoteOffMemory -MidiNote $MidiNote
        
    }

    }else{
    
    $MidiNote = ($MidiObj | Where-Object {$_.letter -eq $Note.Letter -and $_.Octave -eq $Note.Octave}).MidiMapping

    
    $ReturnString = @'
    Send-MidiNoteOnMessage -Note {0} -Velocity 100 -Channel 0 -Port $Port
'@ -f $MidiNote
     
    }
    $ReturnString | Out-File -FilePath $CurrentSong -Append
    $CurrentTime = Get-CurrentTime
    Write-MidiMemory -MidiNote $MidiNote -Length $CurrentTime
    Write-NoteOffMemory -MidiNote $MidiNote

}