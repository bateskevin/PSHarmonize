enum Mood {
    Major
    Minor
}

Class Chord{
    [Note]$Root
    [Note[]]$Notes
    [String]$Type
    [Mood]$Mood
    [String]$ChordName


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

        $This.chordName = "$($This.root.Letter)$($this.Type)"
    }

    Show(){
        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
        $Content = (Get-Content $ModulePath\Style\ChordSheetTemplate.txt)
        $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
        $LineObj = $LineJSON | ConvertFrom-Json

        $Count = 0

        $NewContent = @()
        $NoteCounter = 0

        $NoteCount = $this.Notes.Count

        Foreach($Line in $Content){
            $check = $true
            $NewLine = ""
            foreach($Note in $this.Notes.Letter){
                if($check){
                    if(($LineObj | where-Object {$_.line -eq $count}).Mood -contains $Note -and ($LineObj | where-Object {$_.line -eq $count}).line[0] -le ($LineObj | where-Object {$_.mood -contains $this.root.Letter}).line[0] -and $NoteCounter -le $NoteCount){
                        if($Note -like "*#" -or $Note -Like "*b"){
    
                            $Addition = ($LineObj | where-Object {$_.line -eq $count}).Addition
    
                            if($Line -Like "* (@) *"){
                                $NewLine = $Line.Replace("(@) ","(@)$Addition")
                                #$NewContent += $NewLine
                            }elseif($Line -like "*-(@)-*"){
                                $NewLine = $Line.Replace("(@)-","(@)$Addition")
                                #$NewContent += $NewLine
                            }elseif($Line -like "*_(@)_*"){
                                $NewLine = $Line.Replace("(@)_","(@)$Addition")
                                #$NewContent += $NewLine
                            }
                            $check = $false
                         }else{
                            $NewLine = $Line 
                            $check = $false
                         }
                         $NoteCounter++
                        
                     }else {    
                        if($Line -Like "* (@) *"){
                            $NewLine = $Line.Replace("(@)","")
                            #$NewContent += $NewLine
                        }elseif($Line -like "*-(@)-*"){
                            $NewLine = $Line.Replace("(@)","---")
                            #$NewContent += $NewLine
                        }elseif($Line -like "*_(@)_*"){
                            $NewLine = $Line.Replace("(@)","___")
                            #$NewContent += $NewLine
                        }
                        #$check = $false
                     }
                }
            }

            $NewContent += $NewLine
            

            $Count++ 
        }

        $NewContent | out-file -FilePath "$ModulePath\Style\Dump\$($This.ChordName).txt"

    }
}