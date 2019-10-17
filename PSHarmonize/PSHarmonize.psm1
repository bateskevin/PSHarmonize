#Generated at 10/17/2019 22:00:28 by Kevin Bates
Class Note {
    [String]$Letter
    [Int]$NoteMapping
    [int]$Octave
    [String]$EnharmonicFlavour 
    [int]$Numeral

    
 
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
enum Mood {
    Major
    Minor
}
 


Class Major7 {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood

    Major7 ($Root,$Mood){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $This.Root = $Root
        $This.Mood = $Mood
        
        $Major7JSON = (Get-Content $ModulePath\Facts\Major7s.json)
        $Major7Obj = $Major7JSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()

        Foreach($Interval in $Major7Obj.$Mood){
            $Interval = [convert]::ToInt32($Interval)
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval + $RootNoteMapping) - 12
                If(($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter.count -eq 1){
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter  
                }else{
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter 
                }
                $Note = [Note]::new($Letter)
                $NewOctave = $This.Root.Octave + 1
                $Note.OverrideOctave($NewOctave)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note

            }elseif(($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter.count -ne 1){
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note
            }
            
        }

        $This.Notes = $NoteArr

    }


}


Class Triad {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood

    Triad ($Root,$Mood){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $This.Root = $Root
        $This.Mood = $Mood
        
        $TriadJSON = (Get-Content $ModulePath\Facts\Triads.json)
        $TriadObj = $TriadJSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()

        Foreach($Interval in $TriadObj.$Mood){
            $Interval = [convert]::ToInt32($Interval)
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval + $RootNoteMapping) - 12
                If(($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter.count -eq 1){
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter  
                }else{
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter 
                }
                $Note = [Note]::new($Letter)
                $NewOctave = $This.Root.Octave + 1
                $Note.OverrideOctave($NewOctave)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note

            }elseif(($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter.count -ne 1){
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note
            }
            
        }

        $This.Notes = $NoteArr

    }


}

Class Dominant7 {
    [Note]$Root
    [Note[]]$Notes
    [Mood]$Mood

    Dominant7 ($Root,$Mood){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $This.Root = $Root
        $This.Mood = $Mood
        
        $Dominant7JSON = (Get-Content $ModulePath\Facts\Dominant7s.json)
        $Dominant7Obj = $Dominant7JSON | ConvertFrom-Json
        $NotesJSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
        $NotesObj = $NotesJSON | ConvertFrom-Json
        $RootNoteMapping = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).NoteMapping
        $RootNoteEnharmonicFlavour = ($NotesObj | Where-Object {$_.Letter -eq $Root.Letter}).EnharmonicFlavour

        $NoteArr = @()

        Foreach($Interval in $Dominant7Obj.$Mood){
            $Interval = [convert]::ToInt32($Interval)
            if(($RootNoteMapping + $Interval) -gt 12){
                $NewNoteMapping = ($Interval + $RootNoteMapping) - 12
                If(($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter.count -eq 1){
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($NewNoteMapping)}).Letter  
                }else{
                    $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq $NewNoteMapping -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter 
                }
                $Note = [Note]::new($Letter)
                $NewOctave = $This.Root.Octave + 1
                $Note.OverrideOctave($NewOctave)
                #$Note.NoteMappingOverflow(($RootNoteMapping + $Interval))
                $NoteArr += $Note

            }elseif(($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter.count -ne 1){
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval) -and $RootNoteEnharmonicFlavour -eq $_.EnharmonicFlavour}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note 
            }else{
                $Letter = ($NotesObj | Where-Object {$_.NoteMapping -eq ($RootNoteMapping + $Interval)}).Letter
                $Note = [Note]::new($Letter)
                $NoteArr += $Note
            }
            
        }

        $This.Notes = $NoteArr

    }


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

        $This.chordName = "$($This.root.Letter)$($This.Mood)$($this.Type)"
    }

    Show(){
        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
        $Content = (Get-Content $ModulePath\Style\ChordSheetTemplate.txt)
        [array]::Reverse($Content)
        $LineJSON = (Get-Content $ModulePath\Facts\SheetMapping.json)
        $LineObj = $LineJSON | ConvertFrom-Json

        $Count = 0

        $NewContent = @()
        $AlreadyIn = @()
        $NoteCounter = 0

        $NoteCount = $this.Notes.Count

        Foreach($Line in $Content){
            $check = $true
            $NewLine = ""
            foreach($Note in $this.Notes.Letter){
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
                                $NewLine = $Line.Replace("(@) ","(@)$Addition")
                                #$NewContent += $NewLine
                            }elseif($Line -like "*-(@)-*"){
                                $NewLine = $Line.Replace("(@)-","(@)$($Addition)-")
                                #$NewContent += $NewLine
                            }elseif($Line -like "*_(@)_*"){
                                $NewLine = $Line.Replace("(@)_","(@)$($Addition)_")
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

        [array]::Reverse($NewContent)

        $NewContent | out-file -FilePath "$ModulePath\Style\$($This.ChordName).txt"

    }
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
Function Get-BPMValues {
    param(
        [int]$BPM
    )

    $1Beat = (1 / $BPM ) * 60

    $BPMHash = [ordered]@{
        Quarter = $1Beat * 1000
        Eight = ($1Beat / 2) * 1000
        Sixteenth = ($1Beat / 4) * 1000
    }
    
    $BPMObj = New-Object psobject -Property $BPMHash

    return $BPMObj

}
Function Get-PHScale {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Scale = [Scale]::new($RootNote,$Mood)

    $Scale

    #($Scale.Notes | select * | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)
    
    

}
Function Get-PHChord {
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood,
        [ValidateSet('Triad','Major7','Dominant7')]
        [String]$Type
    )

    $RootNote = [Note]::new($Root)

    $Chord = [Chord]::new($RootNote,$Type,$Mood)

    $Chord

}
Function Get-PHChordProgression {
    
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet(1,2,3,4,5,6,7)]
        [int[]]$Numbers,
        [Switch]$ViewChords
    )
    
    $Key = [Note]::new($Root)
    $ChordProg = [ChordProgression]::new($key,$numbers)

    if($ViewChords){
        foreach($Number in $Numbers){
            $Chord = $ChordProg.Chords[$number - 1]
            Write-Host "Chord on Numeral $($Chord.Root.Numeral)"
            $Chord.Notes
        }
    }else{
        $ChordProg
    }

}
Function Get-PHChordProgressionTranspose {
    
    param(
        [ChordProgression]$ChordProgression,
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$To
    )
    
    
    $ChordProg = [ChordProgression]::new($To,$ChordProgression.numbers)

    return $ChordProg
    

}
Function Get-PHDominant7 {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Dominant7 = [Dominant7]::new($RootNote,$Mood)

    ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)

}
Function Get-PHMajor7 {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Major7 = [Major7]::new($RootNote,$Mood)

    ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)

}
Function Get-PHNote {
    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Note
    )

    

    if(!($Note)){
        $NoteArr = @()
        $PresetArr = 'C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B'
        foreach($Note in $PresetArr){
            $ArrNote = [Note]::new($Note)
            $NoteArr += $ArrNote

        }

    return $NoteArr
    }else{
        $ReturnNote = [Note]::new($Note)
        return $ReturnNote
    }
}
Function Get-PHTriad {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood
    )

    $RootNote = [Note]::new($Root)

    $Triad = [Triad]::new($RootNote,$Mood)

    ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)

}
Function Show-PHChord {
    param(
        [Chord]$Chord
    )
    
    $Chord.Show()

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $Content = Get-Content "$ModulePath\Style\$($Chord.ChordName).txt"

        Foreach($Line in $Content){
            $Line
        }

    $null = Get-ChildItem "$ModulePath\Style\$($Chord.ChordName).txt" | Remove-Item -Force

}
Function Show-PHChordHTML {

    param (
        [Chord]$Chord,
        $Path = $PSScriptRoot,
        $Name = "index.html"
    )   

$ChordStringArr = @() 

    Foreach($Note in $Chord.Notes){
        $String = '"{0}/{1}"' -f $($Note.Letter), $($Note.Octave)
        $ChordStringArr += $String
    }

$ChordString = $ChordStringArr -join ", "

#ipmo .\PSHarmonize\PSHarmonize\PSHarmonize.psd1 -Force

Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3

$ScriptContent =  @"
           
    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 500,
    canvasHeight: 500
};

// Create a renderer with SVG
var renderer = new VF.Renderer(
    WorkspaceInformation.div,
    VF.Renderer.Backends.SVG
);

// Use the renderer to give the dimensions to the SVG
renderer.resize(WorkspaceInformation.canvasWidth, WorkspaceInformation.canvasHeight);

// Expose the context of the renderer
var context = renderer.getContext();

// And give some style to our SVG
context.setFont("Arial", 10, "").setBackgroundFillStyle("#eed");


/**
 * Creating a new stave
 */
// Create a stave of width 400 at position x10, y40 on the SVG.
var stave = new VF.Stave(10, 40, 400);
// Add a clef and time signature.
stave.addClef("treble").addTimeSignature("4/4");
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();


/**
* Draw notes
 */

var notes = [
    // A C-Major chord.
    new VF.StaveNote({clef: "treble", keys: [$ChordString], duration: "q" }),
    new VF.StaveNote({clef: "treble", keys: ["b/4"], duration: "qr" }),
    new VF.StaveNote({clef: "treble", keys: ["b/4"], duration: "qr" }),
    new VF.StaveNote({clef: "treble", keys: ["b/4"], duration: "qr" })
    
];

// Create a voice in 4/4 and add above notes
var voice = new VF.Voice({num_beats: 4,  beat_value: 4});
voice.addTickables(notes);

// Format and justify the notes to 400 pixels.
var formatter = new VF.Formatter().joinVoices([voice]).format([voice], 400);

// Render voice
voice.draw(context, stave);

"@

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        h1 "$($Chord.ChordName)"
        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML

}
Function Show-PHChordProgression {
    param(
        [ChordProgression]$ChordProgression
    )
    
    $ChordProgression.Show()

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $Content = Get-Content "$ModulePath\Style\$($ChordProgression.Key.Letter)$($ChordProgression.Numbers).txt"

        Foreach($Line in $Content){
            $Line
        }

    $ChildItem = Get-ChildItem $ModulePath\Style\ | Where-Object {$_.Name -notlike "*template.txt"}

    $null = $ChildItem.FullName | Remove-Item -Force

}
Function Show-PHChordProgressionHTML {

    param (
        [CHordprogression]$CHordprogression,
        $Path = $PSScriptRoot,
        $Name = "index.html"
    )

#ipmo .\PSHarmonize\PSHarmonize\PSHarmonize.psd1 -Force

Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3




    $ChordArr = @()
    
    foreach($Chord in $CHordprogression.Chords){
        #// A C-Major chord.
        $Output = @"
new VF.StaveNote({clef: "treble", keys: ["$($CHord.NOtes[0].Letter)/$($CHord.Notes[0].Octave)", "$($CHord.NOtes[1].Letter)/$($CHord.Notes[1].Octave)", "$($CHord.NOtes[2].Letter)/$($CHord.Notes[2].Octave)"], duration: "q" })
"@ 
        $ChordArr += $Output
    }


$ScriptContent =  @"
           
    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 500,
    canvasHeight: 500
};

// Create a renderer with SVG
var renderer = new VF.Renderer(
    WorkspaceInformation.div,
    VF.Renderer.Backends.SVG
);

// Use the renderer to give the dimensions to the SVG
renderer.resize(WorkspaceInformation.canvasWidth, WorkspaceInformation.canvasHeight);

// Expose the context of the renderer
var context = renderer.getContext();

// And give some style to our SVG
context.setFont("Arial", 10, "").setBackgroundFillStyle("#eed");


/**
 * Creating a new stave
 */
// Create a stave of width 400 at position x10, y40 on the SVG.
var stave = new VF.Stave(10, 40, 400);
// Add a clef and time signature.
stave.addClef("treble").addTimeSignature("4/4");
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();


/**
* Draw notes
 */

var notes = [
    // A C-Major chord.
 $($ChordArr -join ",")
    
];

// Create a voice in 4/4 and add above notes
var voice = new VF.Voice({num_beats: 4,  beat_value: 4});
voice.addTickables(notes);

// Format and justify the notes to 400 pixels.
var formatter = new VF.Formatter().joinVoices([voice]).format([voice], 400);

// Render voice
voice.draw(context, stave);

"@

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML

}
