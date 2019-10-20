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

    
 
    Note($Letter){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
        $This.Octave = 3
    }

    Note($Letter,$Length,$Velocity){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NoteMappingObj = $JSON | ConvertFrom-Json
        $This.Letter = $Letter
        $This.NoteMapping = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).NoteMapping
        $This.EnharmonicFlavour = ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter}).EnharmonicFlavour
        $This.Octave = 4
        $This.Length = $Length
        $This.Velocity = $Velocity
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