Function Get-PHTriad {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood = "Major",
        [ValidateSet(1,2)]
        [Int]$Inversion
    )

    $RootNote = [Note]::new($Root)

    $Triad = [Triad]::new($RootNote,$Mood)

    if($Inversion){
        Switch ($Inversion) {
            1 {
                $Octave = ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave
                ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave = $Octave + 1
            }

            2 {
                $Count = 0
                foreach($Instance in ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 2){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }
        }

        $5andOver = @()
        $ok = @()

        Foreach($instance in $Triad.Notes){
            if($Instance.Octave -ge 5){
                $5andOver += $Instance
            }else{
                $ok += $Instance
            }
        }

        if($ok.count -eq 0){
            foreach($instance in $Triad.Notes){
                $Instance.Octave = $Instance.octave -1
            }
        }        
    }
    
    ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)
    

    

}