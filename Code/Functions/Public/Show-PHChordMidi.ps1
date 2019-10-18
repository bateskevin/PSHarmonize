Function Show-PHChordMidi {
    param(
        [Chord]$Chord,
        [int]$BPM
    )
    
    Ipmo C:\Users\Kevin\Downloads\PeteBrown.PowerShellMidi.dll

    Get-BPMValues -BOM $BPM



}