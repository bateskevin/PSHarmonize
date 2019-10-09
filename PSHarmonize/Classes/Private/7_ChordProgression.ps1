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
        $This.Numbers = $Numbers

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

    Show(){
        $ChordCount = 1        
        Foreach($Chord in $This.Chords){
            if($ChordCount -eq 1){
                $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
                $Content = (Get-Content $ModulePath\Style\ChordSheetTemplate.txt)
                [array]::Reverse($Content)
                $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
                $LineObj = $LineJSON | ConvertFrom-Json

                $Count = 0

                $NewContent = @()
                $AlreadyIn = @()
                $NoteCounter = 0

                $NoteCount = $Chord.Notes.Count

                Foreach($Line in $Content){
                    $check = $true
                    $NewLine = ""
                    foreach($Note in $Chord.Notes.Letter){
                        if($check){

                            if((($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[0] -le 3){
                                $RootValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[1]
                                $RefferenceValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[2]
                            }else{
                                $RootValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[0] 
                                $RefferenceValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[1]
                            }

                            if(($LineObj | where-Object {$_.line -eq $count}).Mood -contains $Note -and ($LineObj | where-Object {$_.line -eq $count}).line -ge $RootValue  -and ($LineObj | where-Object {$_.line -eq $count}).line -le $RefferenceValue -and $NoteCounter -le $NoteCount -and $AlreadyIn -notcontains $Note){
                                if($Note -clike "*#" -or $Note -cLike "*b"){
            
                                    $Addition = ($Note.ToChararray())[1]
                                    #$Addition = ($LineObj | where-Object {$_.line -eq $count}).Addition
            
                                    if($Line -Like "* (@) *"){
                                        $NewLine = $Line.Replace(" (@)","$Addition(@)")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*--(@)-*"){
                                        $NewLine = $Line.Replace("--(@)-","-$($Addition)(@)-")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*__(@)_*"){
                                        $NewLine = $Line.Replace("__(@)_","_$($Addition)(@)_")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "* -(@)-*"){
                                        $NewLine = $Line.Replace(" -(@)-","-$($Addition)(@)-")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "* _(@)_*"){
                                        $NewLine = $Line.Replace(" _(@)_","_$($Addition)(@)_")
                                        #$NewContent += $NewLine
                                    }
                                    $check = $false
                                }else{
                                    $NewLine = $Line 
                                    $check = $false
                                }
                                $AlreadyIn += $Note
                                $NoteCounter++
                                
                            }else {    
                                if($Line -Like "* (@) *"){
                                    $NewLine = $Line.Replace("(@)","   ")
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

                [array]::Reverse($NewContent)

                $NewContent | out-file -FilePath "$ModulePath\Style\$($ChordCount)$($Chord.ChordName).txt"
            }else{
                $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
                $Content = (Get-Content $ModulePath\Style\ChordSheetOnGoingTemplate.txt)
                [array]::Reverse($Content)
                $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
                $LineObj = $LineJSON | ConvertFrom-Json

                $Count = 0

                $NewContent = @()
                $AlreadyIn = @()
                $NoteCounter = 0

                $NoteCount = $Chord.Notes.Count

                Foreach($Line in $Content){
                    $check = $true
                    $NewLine = ""
                    foreach($Note in $Chord.Notes.Letter){
                        if($check){

                            if((($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[0] -le 3){
                                $RootValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[1]
                                $RefferenceValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[2]
                            }else{
                                $RootValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[0] 
                                $RefferenceValue = (($LineObj | where-Object {$_.mood -contains $Chord.root.Letter}).line)[1]
                            }

                            if(($LineObj | where-Object {$_.line -eq $count}).Mood -contains $Note -and ($LineObj | where-Object {$_.line -eq $count}).line -ge $RootValue  -and ($LineObj | where-Object {$_.line -eq $count}).line -le $RefferenceValue -and $NoteCounter -le $NoteCount -and $AlreadyIn -notcontains $Note){
                                if($Note -clike "*#" -or $Note -cLike "*b"){
            
                                    $Addition = ($Note.ToChararray())[1]
                                    #$Addition = ($LineObj | where-Object {$_.line -eq $count}).Addition
            
                                    if($Line -Like "* (@) *"){
                                        $NewLine = $Line.Replace(" (@)","$Addition(@)")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*-(@)- *"){
                                        $NewLine = $Line.Replace(" -(@)-","-$Addition(@)-")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*_(@)_ *"){
                                        $NewLine = $Line.Replace(" _(@)_","_$($Addition)(@)_")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*--(@)-*"){
                                        $NewLine = $Line.Replace("--(@)-","-$($Addition)(@)-")
                                        #$NewContent += $NewLine
                                    }elseif($Line -like "*__(@)_*"){
                                        $NewLine = $Line.Replace("__(@)_","_$($Addition)(@)_")
                                        #$NewContent += $NewLine
                                    }
                                    $check = $false
                                }else{
                                    $NewLine = $Line 
                                    $check = $false
                                }
                                $AlreadyIn += $Note
                                $NoteCounter++
                                
                            }else {    
                                if($Line -Like "* (@) *"){
                                    $NewLine = $Line.Replace("(@)","   ")
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

                [array]::Reverse($NewContent)

                $NewContent | out-file -FilePath "$ModulePath\Style\$($ChordCount)$($Chord.ChordName).txt"
            }

            $ChordCount++
        }

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
        $ChildItem = Get-ChildItem $ModulePath\Style\ | Where-Object {$_.Name -notlike "*template.txt"}

        $Count = 0

        $NewFileArr = @()

        Foreach($Item in (Get-Content $ChildItem[0].FullName)){
            #$First = Get-Content $Item.FullName 

            #$NewLine = $First[$count]
            $NewLine = ""

            Foreach($File in $ChildItem){
                $FileContent = Get-Content $File.FullName
                $NewLine = $NewLine + $FileContent[$count]
            }

            $NewFileArr += $NewLine

            $Count++
        }

        $NewFileArr | out-file -FilePath "$ModulePath\Style\$($This.Key.Letter)$($This.Numbers).txt"
        
    }

}