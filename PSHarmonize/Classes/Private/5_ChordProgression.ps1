enum Mood {
    Major
    Minor
}
 


Class ChordProgression {
    [Note]$Key
    [Note[]]$Chords
    [int[]]$Numbers

    ChordProgression ($Root,$Numbers){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        #$This.Root = $Key
        
        $ChordProgressionJSON = (Get-Content $ModulePath\Facts\Moods.json)
        $ChordProgressionObj = $ChordProgressionJSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $ChordArr = @()

        Foreach($Numbers in $Numbers){
            
        }

        

    }


}