Function Get-PHChordProgressionTranspose {
    
    param(
        [ChordProgression]$ChordProgression,
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$To
    )
    
    
    $ChordProg = [ChordProgression]::new($To,$ChordProgression.numbers)

    return $ChordProg
    

}