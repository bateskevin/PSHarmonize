Class Note {
    [String]$Letter
    [Int]$NoteMapping
    [int]$Octave
    [String]$EnharmonicFlavour 

    Note($Letter){
        $JSON = (Get-Content ..\..\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
    }

    note($letter,$Octave){
        $JSON = (Get-Content ..\..\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.Octave = $Octave
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
    }

    NoteMappingOverflow($NewNoteMapping){
        $This.NoteMapping = $NewNoteMapping
    }

}