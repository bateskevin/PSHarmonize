Function Show-PHChord {
    param(
        [Chord]$Chord
    )

    $Chord.Show()

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $Content = Get-Content "$ModulePath\Style\Dump\$($Chord.ChordName).txt"

        Foreach($Line in $Content){
            $Line
        }

}