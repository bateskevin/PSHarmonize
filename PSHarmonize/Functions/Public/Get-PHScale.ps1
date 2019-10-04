Function Get-PHScale {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Scale = [Scale]::new($RootNote,$Mood)

    ($Scale.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)

}