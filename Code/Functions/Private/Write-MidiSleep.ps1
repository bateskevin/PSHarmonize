Function Write-MidiSleep {
    param(
        $Length
    )

    $BPM = Get-BPMValue

    $BPMObj = Get-BPM -BPM $BPM 

    $Sixteenth = $BPMObj.Sixteenth

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    Switch ($Length) {
        "Semibreve" {$SleepLength = 16 * $Sixteenth}
        "Minim" {$SleepLength = 8 * $Sixteenth}
        "Crotchet" {$SleepLength = 4 * $Sixteenth}
        "Quaver" {$SleepLength = 2 * $Sixteenth}
        "Semiquaver" {$SleepLength = 1 * $Sixteenth}
    }

    $ReturnString = @"
Start-Sleep $SleepLength
"@

    $ReturnString | Out-File -FilePath $CurrentSong -Append

}