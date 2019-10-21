Function F# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood 
    )
 

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        
    }elseif($Midi){

    }else{

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
            }else{
                $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
            }
            return $ChordNotes
        }
        
    }

    

}