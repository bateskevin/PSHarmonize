Function Out-MidiFile {
    param(
        $String
    )

    $CurrentSong = Join-Path $PSScriptRoot "MidiTemp\CurrentSong.ps1"

    $String | Out-File -FilePath $CurrentSong -Append

}