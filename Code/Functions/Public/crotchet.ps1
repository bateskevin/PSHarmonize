Function Crotchet {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name

    If($Notation){

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    }elseif($Midi){

    }else{
        return $Note
    }

    

}

