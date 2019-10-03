enum Mood {
    Major
    Minor
}

Class Triad {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood

    Triad ($Root,$Mood){
        $This.Root = $Root
        $This.Mood = $Mood
        
        $TriadJSON = (Get-Content ..\..\Facts\Triads.json)
        $TriadObj = $TriadJSON | ConvertFrom-Json
        $NotesJSON = (Get-Content ..\..\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()

        Foreach($Interval in $TriadObj.$Mood){
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval - $RootNoteMapping)
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note 
            }
            
        }

        $This.Notes = $NoteArr

    }


}