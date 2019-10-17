Function Get-PHChord {
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood,
        [ValidateSet('Triad','Major7','Dominant7')]
        [String]$Type
    )

    $RootNote = [Note]::new($Root)

    $Chord = [Chord]::new($RootNote,$Type,$Mood)

    $Chord

}