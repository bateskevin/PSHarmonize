Function Get-PHNote {
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Note
    )

    

    if(!($Note)){
        $NoteArr = @()
        $PresetArr = 'C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B'
        foreach($Note in $PresetArr){
            $ArrNote = [Note]::new($Note)
            $NoteArr += $ArrNote

        }

    return $NoteArr
    }else{
        $ReturnNote = [Note]::new($Note)
        return $ReturnNote
    }
}