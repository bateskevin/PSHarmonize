Function G {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi
    )

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){

        $NoteLength = Get-NoteLength -Length $Length -Notation

        Write-NotationNote $Note $NoteLength
    }elseif($Midi){

    }else{
        return $Note
    }

    

}