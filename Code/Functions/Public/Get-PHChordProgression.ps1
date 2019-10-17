Function Get-PHChordProgression {
    
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet(1,2,3,4,5,6,7)]
        [int[]]$Numbers,
        [Switch]$ViewChords
    )
    
    $Key = [Note]::new($Root)
    $ChordProg = [ChordProgression]::new($key,$numbers)

    if($ViewChords){
        foreach($Number in $Numbers){
            $Chord = $ChordProg.Chords[$number - 1]
            Write-Host "Chord on Numeral $($Chord.Root.Numeral)"
            $Chord.Notes
        }
    }else{
        $ChordProg
    }

}