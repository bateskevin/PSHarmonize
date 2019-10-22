Function quaver {

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

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

}

