enum Mood {
    Major
    Minor
}

Class Chord{
    [Note]$Root
    [Note[]]$Notes
    [String]$Type
    [Mood]$Mood


    Chord($Root,$Type,$Mood){
        $This.Type = $Type
        $This.Root = $Root
        $this.Mood = $Mood


        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping

        
        Switch($Type){
            "Triad" {$This.Notes = Get-PHTriad $Root.Letter $Mood}
            "Dominant7" {$This.Notes = Get-PHDominant7 $Root.Letter $Mood}
            "Major7" {$This.Notes = Get-PHmajor7 $Root.Letter $Mood}
        }
    }
}