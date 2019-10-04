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
        $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
        $LineObj = $NotesJSON | ConvertFrom-Json
        
        Switch($Type){
            "Triad" {$This.Notes = Get-PHTriad $Root.Letter $Mood}
            "Dominant7" {$This.Notes = Get-PHDominant7 $Root.Letter $Mood}
            "Major7" {$This.Notes = Get-PHmajor7 $Root.Letter $Mood}
        }
    }

    Show(){
        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
        $Content = (Get-Content $ModulePath\Style\ChordSheetTemplate.txt)
        $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
        $LineObj = $LineJSON | ConvertFrom-Json

        $Count = 0

        $NewContent = @()

        Foreach($Line in $Content){

            if($Letter -contains ($LineObj | where-Object {$_.line -eq $count}).Mood){
               $NewContent += $Line 
            }else{

                if($Line -match " (@) "){
                    $NewLine = $Line.Replace("(@)","")
                    $NewContent += $NewLine
                }elseif($Line -match "-(@)-"){
                    $NewLine = $Line.Replace("(@)","---")
                    $NewContent += $NewLine
                }elseif($Line -match "_(@)_"){
                    $NewLine = $Line.Replace("(@)","___")
                    $NewContent += $NewLine
                }

            }

            $Count++ 
        }

        $NewContent | out-file -FilePath "$ModulePath\Style\Dump\Chord.txt"

    }
}