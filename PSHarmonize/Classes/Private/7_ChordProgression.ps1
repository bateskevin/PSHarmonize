enum Mood {
    Major
    Minor
}
 


Class ChordProgression {
    [Note]$Key
    [Chord[]]$Chords
    [int[]]$Numbers

    ChordProgression ($Root,$Numbers){

        $This.Key = $Root

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $ScaleOfKey = Get-PHScale -Root $This.Key.Letter -Mood "Major" -CodeBase
        
        $ChordProgressionJSON = (Get-Content $ModulePath\Facts\Moods.json)
        $ChordProgressionObj = $ChordProgressionJSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $ChordArr = @()

        Foreach($Number in $Numbers){
            $Chord = Get-PHChord -Root ($ScaleOfKey.Notes[$Number - 1].Letter) -Mood ($ChordProgressionObj | Where-Object {$_.RomanNumeral -eq $Number}).Mood -Type "Triad"
            $ChordArr += $Chord
        }

        $This.Chords = $ChordArr       

    }


}