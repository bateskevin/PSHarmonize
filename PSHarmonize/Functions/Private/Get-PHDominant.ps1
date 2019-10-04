Function Get-PHDominant7 {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Dominant7 = [Dominant7]::new($RootNote,$Mood)

    ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)

}