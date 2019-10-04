enum Mood {
    Major
    Minor
}
 


Class Scale {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood
    [int[]]$Numerals

    Scale ($Root,$Mood){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $This.Root = $Root
        $This.Mood = $Mood
        
        $ScaleJSON = (Get-Content $ModulePath\Facts\Scales.json)
        $ScaleObj = $ScaleJSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()
        $Counter = 1
        $ActualRootNote = [Note]::new($Root.Letter)
        $ActualRootNote.AssignNumeral($Counter)
        $NoteArr += $ActualRootNote 
        $Counter++

        Foreach($Interval in ($ScaleObj.$Mood -notlike '')){ 
            $Interval = [convert]::ToInt32($Interval)
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval + $RootNoteMapping) - 12                
                If(($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter.count -eq 1){
                    $NewOctaveLetter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter  
                }else{
                    $NewOctaveLetter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter 
                }

                $Note = [Note]::new($NewOctaveLetter)
                $NewOctave = $This.Root.Octave + 1
                $Note.OverrideOctave($NewOctave)
                $Note.AssignNumeral($Counter)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note

            }elseif(($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter.count -ne 1){
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $Note.AssignNumeral($Counter)
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter
                $Note = [Note]::new($Letter)
                $Note.AssignNumeral($Counter)
                $NoteArr += $Note
            }
            $Counter++
        }

        $ActualLastNote = [Note]::new($Root.Letter)
        $ActualLastNote.AssignNumeral($Counter)
        $NewOctave = $This.Root.Octave + 1
        $ActualLastNote.OverrideOctave($NewOctave)
        $NoteArr += $ActualLastNote

        $This.Notes = $NoteArr

    }
}