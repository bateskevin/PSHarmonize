Function Pause {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi
    )
 
    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("B",$Octave,$True)

    If($Notation){
        return $Note
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}