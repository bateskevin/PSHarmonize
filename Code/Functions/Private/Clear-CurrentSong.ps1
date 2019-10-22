Function Clear-CurrentSong {
    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    Clear-Content $CurrentSong 
}