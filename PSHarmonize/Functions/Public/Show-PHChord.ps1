Function Show-PHChord {
    param(
        [Chord]$Chord
    )
    
    $Chord.Show()

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $Content = Get-Content "$ModulePath\Style\$($Chord.ChordName).txt"

        Foreach($Line in $Content){
            $Line
        }

    $null = Get-ChildItem "$ModulePath\Style\$($Chord.ChordName).txt" | Remove-Item -Force

}