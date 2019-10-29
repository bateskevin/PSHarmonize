Enum Length {
    semibreve
    Minim
    crotchet
    quaver
    semiquaver
}

Class Note {
    [String]$Letter
    [Int]$NoteMapping
    [int]$Octave
    [Length]$Length
    [Int]$Velocity
    [String]$EnharmonicFlavour 
    [int]$Numeral
    [boolean]$IsPause

    
 
    Note($Letter){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
        $This.Octave = 4
    }

    note($letter,$Octave){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path) 

        $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.Octave = $Octave
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
    }

    Note($letter,$Octave,$IsPause){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path) 

        $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.Octave = $Octave
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
        $This.IsPause = $IsPause
    }

    

    NoteMappingOverflow($NewNoteMapping){
        $This.NoteMapping = $NewNoteMapping
    }

    OverrideOctave($Octave){
        $This.Octave = $Octave
    }

    AssignNumeral($Numeral){
        $This.Numeral = $Numeral
    }

}