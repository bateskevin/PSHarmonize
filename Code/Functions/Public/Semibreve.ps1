Function Semibreve {

    param(
        $Content,
        [Switch]$Midi
    )

    $Notation = $true

    If($Notation){

        $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    }elseif($Midi){

    }else{
        return $Note
    }

    

}

