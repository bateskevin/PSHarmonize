
Class Dominant7 {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood

    Dominant7 ($Root,$Mood){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $This.Root = $Root
        $This.Mood = $Mood
        
        $Dominant7JSON = (Get-Content $ModulePath\Facts\Dominant7s.json)
        $Dominant7Obj = $Dominant7JSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()

        Foreach($Interval in $Dominant7Obj.$Mood){
            $Interval = [convert]::ToInt32($Interval)
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval + $RootNoteMapping) - 12
                If(($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter.count -eq 1){
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter  
                }else{
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter 
                }
                $Note = [Note]::new($Letter)
                $NewOctave = $This.Root.Octave + 1
                $Note.OverrideOctave($NewOctave)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note

            }elseif(($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter.count -ne 1){
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note
            }
            
        }

        $This.Notes = $NoteArr

    }


}