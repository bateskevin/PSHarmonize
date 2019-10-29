#Generated at 10/29/2019 15:02:06 by Kevin Bates
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
    $Test


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

    ShowMidi(){

        $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

        $MidiJSON = (Get-Content $ModulePath\Facts\MidiMapping.json)
        $MidiObj = $MidiJSON | ConvertFrom-Json
        
        Import-Module C:\Users\Kevin\Downloads\PeteBrown.PowerShellMidi.dll

        $Device = (Get-MidiOutputDeviceInformation | Where-Object {$_.name -eq "Midi"}).Id

        $Port = Get-MidiOutputPort -Id $Device

        $MidiNoteArr = @()

        Foreach($Note in $This.Notes){
            $MidiNote = ($MidiObj | Where-Object {$_.letter -eq $Note.Letter -and $_.Octave -eq $Note.Octave}).MidiMapping
            $MidiNoteArr += $MidiNote   
        }

        $This.Test = $MidiNoteArr

        Foreach($Note in $MidiNoteArr){
            Send-MidiNoteOnMessage -Note $Note -Velocity 100 -Channel 0 -Port $Port
        }

        Start-sleep -Milliseconds 2000

        Foreach($Note in $MidiNoteArr){
            Send-MidiNoteoffMessage -Note $Note -Velocity 50 -Channel 0 -Port $Port
        }

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
Function Clear-CurrentSong {
    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    Clear-Content $CurrentSong 
}
Function Clear-MidiMemory {
    
    $MemoryHash = @{}

        $MemoryHash.0 = $null
        $MemoryHash.1 = $null
        $MemoryHash.2 = $null
        $MemoryHash.3 = $null
        $MemoryHash.4 = $null
        $MemoryHash.5 = $null
        $MemoryHash.6 = $null
        $MemoryHash.7 = $null
        $MemoryHash.8 = $null
        $MemoryHash.9 = $null
        $MemoryHash.10 = $null
        $MemoryHash.11 = $null
        $MemoryHash.12 = $null
        $MemoryHash.13 = $null
        $MemoryHash.14 = $null
        $MemoryHash.15 = $null
        $MemoryHash.16 = $null


    $MemoryObj = New-Object psobject -Property $MemoryHash

    $MemoryObj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json



}
Function Clear-NoteOffMemory {

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.Notes = @()    
    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\NoteOffMemory.json

}
Function Get-BPM {
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
Function Get-BPMValue {
    $BPMValue = Get-Content $PSScriptRoot\Facts\CurrentBPM.json | Convertfrom-Json

    return $BPMValue.BPM
}
Function Get-Clef {
    $Clef = Get-Content $PSScriptRoot\Facts\CurrentClef.json | Convertfrom-Json

    return $Clef.Clef
}
Function Get-CurrentTime {
    $CurrentTime = Get-Content $PSScriptRoot\Facts\CurrentTime.json | Convertfrom-Json

    return $CurrentTime.CurrentTime
}
Function Get-NoteLength {
    param(
        [Length]$Length,
        [Switch]$Midi
    )

    $Notation = $true

    If($Notation){
        Switch ($Length) {
            "Semibreve" {$NoteLength = 1}
            "Minim" {$NoteLength = 2}
            "Crotchet" {$NoteLength = 4}
            "Quaver" {$NoteLength = 8}
            "Semiquaver" {$NoteLength = 16}
        }
    }elseif($Midi){

    }
    
    Return $NoteLength 

}
Function Get-OutPutMode {
    $OutputMode = Get-Content $PSScriptRoot\Facts\OutPutMode.json | Convertfrom-Json

    return $OutputMode.OutputMode
}
Function Out-MidiFile {
    param(
        $String
    )

    $CurrentSong = Join-Path $PSScriptRoot "MidiTemp\CurrentSong.ps1"

    $String | Out-File -FilePath $CurrentSong -Append

}
Function Set-BPMValue {
    param(
        $BPM
    )


    $JSON = Get-Content $PSScriptRoot\Facts\CurrentBPM.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.BPM = $BPM

    $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentBPM.json

}
Function Set-Clef {
    param(
        [ValidateSet('treble','baritone-f')]
        $Clef
    )

    

    Switch ($clef) {
        "treble" {
            $JSON = Get-Content $PSScriptRoot\Facts\CurrentClef.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.Clef = "treble"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentClef.json
        }
        "baritone-f" {
            $JSON = Get-Content $PSScriptRoot\Facts\CurrentClef.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.Clef = "baritone-f"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentClef.json
        }
    }
}
Function Set-CurrentTime {
    param(
        $CurrentTime
    )


    $JSON = Get-Content $PSScriptRoot\Facts\CurrentTime.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.CurrentTime = $CurrentTime

    $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentTime.json

}
Function Set-OutPutMode {
    param(
        [ValidateSet('Notation','Midi')]
        $OutputMode
    )

    

    Switch ($Outputmode) {
        "Notation" {
            $JSON = Get-Content $PSScriptRoot\Facts\OutPutMode.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.OutputMode = "Notation"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\OutPutMode.json
        }
        "Midi" {
            $JSON = Get-Content $PSScriptRoot\Facts\OutPutMode.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.OutputMode = "Midi"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\OutPutMode.json
        }
    }
}
Function Update-MidiMemory {

    $JSON = Get-Content $PSScriptRoot\Facts\Memory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.0 = $Obj.1
    $Obj.1 = $Obj.2
    $Obj.2 = $Obj.3
    $Obj.3 = $Obj.4
    $Obj.4 = $Obj.5
    $Obj.5 = $Obj.6
    $Obj.6 = $Obj.7
    $Obj.7 = $Obj.8
    $Obj.8 = $Obj.9
    $Obj.9 = $Obj.10
    $Obj.10 = $Obj.11
    $Obj.11 = $Obj.12
    $Obj.12 = $Obj.13
    $Obj.13 = $Obj.14
    $Obj.14 = $Obj.15
    $Obj.15 = $Obj.16

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json

}
Function Write-MidiMemory {
    param(
        $MidiNote,
        $Length
    )

    Switch ($Length) {
        "Semibreve" {$NoteLength = 16}
        "Minim" {$NoteLength = 8}
        "Crotchet" {$NoteLength = 4}
        "Quaver" {$NoteLength = 2}
        "Semiquaver" {$NoteLength = 1}
    }
 
    $JSON = Get-Content $PSScriptRoot\Facts\Memory.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.$NoteLength += $MidiNote

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\Memory.json

}
Function Write-MidiSleep {
    param(
        $Length
    )

    $BPM = Get-BPMValue

    $BPMObj = Get-BPM -BPM $BPM 

    $Sixteenth = $BPMObj.Sixteenth

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    Switch ($Length) {
        "Semibreve" {$SleepLength = 16 * $Sixteenth}
        "Minim" {$SleepLength = 8 * $Sixteenth}
        "Crotchet" {$SleepLength = 4 * $Sixteenth}
        "Quaver" {$SleepLength = 2 * $Sixteenth}
        "Semiquaver" {$SleepLength = 1 * $Sixteenth}
    }

    $ReturnString = @"
Start-Sleep -Milliseconds $SleepLength
"@

    $ReturnString | Out-File -FilePath $CurrentSong -Append

}
Function Write-NoteOffMemory {
    param(
        [int[]]$MidiNote
    )

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    foreach($Note in $MidiNote){
        $Obj.Notes += $Note
    }

    $Obj | ConvertTo-JSON | Out-File -Filepath $PSScriptRoot\Facts\NoteOffMemory.json

}
Function A# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function A {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Ab {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function B {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Bar {
    param (
        $Content,
        [Switch]$LastBar
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    if($Notation){
        $ContentArr = @()

    Foreach($Line in $Content){
        $LineContent = $Line.Invoke()
        $ContentArr += $LineContent
    }

    $VarNotes = $ContentArr -join ", "

    $Bar = @"


    $($Count = 1;Foreach($Line in $ContentArr){
        if($count -lt $ContentArr.Count){
            "$Line,`n"
        }elseif(!($LastBar)){
            "$Line,`n"
        }else{
            "$Line"
        }
        $count++
        })


"@

    Return $Bar
    }elseif($Midi){
        $Content.Invoke()
    }



    

}
Function Bb {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function C# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function C {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Crotchet {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name 

    If($Notation){ 

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    
    }elseif($Midi){

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

}

Function D# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function D {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Db {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function E {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Eb {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function F# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function F {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function G# {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function G {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function Gb {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi,
        [ValidateSet('Major7','Dominant7','Triad')]
        $Chord,
        [ValidateSet('Major','Minor')]
        $Mood,
        [Int]$Inversion
    )
 
    $Mode = Get-OutputMode 

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("$($MyInvocation.MyCommand.Name)",$Octave)

    If($Notation){
        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

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
        [String]$Mood,
        [ValidateSet(1,2,3)]
        [Int]$Inversion
    )

    $RootNote = [Note]::new($Root)

    $Dominant7 = [Dominant7]::new($RootNote,$Mood)

    if($Inversion){
        Switch ($Inversion) {
            1 {
                $Octave = ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave
                ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave = $Octave + 1
            }

            2 {
                $Count = 0
                foreach($Instance in ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 2){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }

            3 {
                $Count = 0
                foreach($Instance in ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 3){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }
        }

        $5andOver = @()
        $ok = @()

        Foreach($instance in $Dominant7.Notes){
            if($Instance.Octave -ge 5){
                $5andOver += $Instance
            }else{
                $ok += $Instance
            }
        }

        if($ok.count -eq 0){
            foreach($instance in $Dominant7.Notes){
                $Instance.Octave = $Instance.octave -1
            }
        }        
    }
    
    ($Dominant7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)
    

    

}
Function Get-PHMajor7 {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood,
        [ValidateSet(1,2,3)]
        [Int]$Inversion
    )

    $RootNote = [Note]::new($Root)

    $Major7 = [Major7]::new($RootNote,$Mood)
    
    if($Inversion){
        Switch ($Inversion) {
            1 {
                $Octave = ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave
                ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave = $Octave + 1
            }

            2 {
                $Count = 0
                foreach($Instance in ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 2){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }

            3 {
                $Count = 0
                foreach($Instance in ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 3){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Major7.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }
        }

        $5andOver = @()
        $ok = @()

        Foreach($instance in $Major7.Notes){
            if($Instance.Octave -ge 5){
                $5andOver += $Instance
            }else{
                $ok += $Instance
            }
        }

        if($ok.count -eq 0){
            foreach($instance in $Major7.Notes){
                $Instance.Octave = $Instance.octave -1
            }
        }        
    }
    
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
Function Get-PHTriad {

    param(
        [ValidateSet('C','C#','Db','D','D#','Eb','E','F','F#','Gb','G','G#','Ab','A','A#','Bb','B')]
        [String]$Root,
        [ValidateSet('Major','Minor')]
        [String]$Mood = "Major",
        [ValidateSet(1,2)]
        [Int]$Inversion
    )

    $RootNote = [Note]::new($Root)

    $Triad = [Triad]::new($RootNote,$Mood)

    if($Inversion){
        Switch ($Inversion) {
            1 {
                $Octave = ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave
                ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[0].Octave = $Octave + 1
            }

            2 {
                $Count = 0
                foreach($Instance in ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)){
                    if($Count -lt 2){
                        $Instance.octave = $Instance.Octave + 1
                    }else{
                        if(!($Instance.Octave -ge 4)){
                            $Instance.octave = $Instance.Octave - 1
                        }
                    }
                    $Count++
                }
                

                #$Octave = ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)[1].Octave
                
            }
        }

        $5andOver = @()
        $ok = @()

        Foreach($instance in $Triad.Notes){
            if($Instance.Octave -ge 5){
                $5andOver += $Instance
            }else{
                $ok += $Instance
            }
        }

        if($ok.count -eq 0){
            foreach($instance in $Triad.Notes){
                $Instance.Octave = $Instance.octave -1
            }
        }        
    }
    
    ($Triad.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)
    

    

}
Function Line {
    param (
        $Content,
        [int]$NumberOfBeats,
        $Label,
        [ValidateSet('treble','baritone-f')]
        $Clef = "treble",
        [String[]]$Ties,
        [String]$TimeSignature = "4/4",
        [String]$Key = "C"
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    If($notation){
        Set-Clef $Clef
    $CurrentClef = Get-Clef

    $ContentArr = @()

    Foreach($Line in $Content){
        $LineContent = $Line.Invoke()
        $ContentArr += $LineContent
    }

    $VarNotes = $ContentArr -join ", "

    if($Ties){
        $TieArr = @()

    Foreach($String in $Ties){

        $Split = $String.Split("-")

        $FirstNoteBeat = $Split[0].Split("/")[0]
        $FirstNoteHeight = $Split[0].Split("/")[1]
        $TieNoteBeat = $Split[1].Split("/")[0]
        $TieNoteHight = $Split[1].Split("/")[1]

        $Tie = @"
    new VF.StaveTie({
        first_note: notes[$FirstNoteBeat],
        last_note: notes[$TieNoteBeat],
        first_indices: [$FirstNoteHeight],
        last_indices: [$TieNoteHight]
      })    
"@

      $TieArr += $Tie

    }


    $TieContainer =@"

    var ties = [
        
$($tieArr -join ",`n")

      ];
      ties.forEach(function(t) {t.setContext(context).draw()})


"@ 

    }

    

    

    $Bar = @"

    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 850,
    canvasHeight: 135
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
var stave = new VF.Stave(10, 40, 800);
// Add a clef and time signature.
stave.addClef("$CurrentClef").addTimeSignature("$TimeSignature").addKeySignature("$key");
// stave.addModifier(keySig);
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();

var notes = [
$($Content.Invoke())
];

// Create a voice in 4/4 and add above notes
//var $Label = new VF.Voice({num_beats: $NumberOfBeats,  beat_value: 4});
//$Label.addTickables(notes);

var beams = VF.Beam.generateBeams(notes);
VF.Formatter.FormatAndDraw(context, stave, notes);
beams.forEach(function(b) {b.setContext(context).draw()})

$TieContainer

// Format and justify the notes to 400 pixels.
//var formatter = new VF.Formatter().joinVoices([$Label]).format([$Label], 750);

// Render voice
//$Label.draw(context, stave);

"@
write-host "your key is: $key"
    Return $Bar
    }elseif($Midi){
        $Content.Invoke()
    }

    

}
Function Minim {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name 

    If($Notation){ 

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    
    }elseif($Midi){

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

}

Function Pause {

    param(
        $Octave = 4,
        [Length]$Length,
        $Velocity,
        [Switch]$Notation,
        [Switch]$Midi
    )
 
    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $Note = [Note]::new("B",$Octave,$True)

    If($Notation){
        return $Note
    }elseif($Midi){

        if(!($Chord)){
            return $Note
        }else{
            if($Mood){
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) $Mood"
                }
                
            }else{
                if($Inversion){
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major -Inversion $Inversion"
                }else{
                    $ChordNotes = Invoke-Expression "Get-PH$($chord) $($MyInvocation.MyCommand.Name) Major"
                }
                
            }
            return $ChordNotes
        }
    }

    

}
Function quaver {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name 

    If($Notation){ 

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    
    }elseif($Midi){

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

}

Function Semibreve {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name 

    If($Notation){ 

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    
    }elseif($Midi){

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

}


Function semiquaver {

    param(
        $Content,
        [Switch]$Midi
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    $NoteLength = Get-NoteLength -Length $MyInvocation.MyCommand.Name 

    If($Notation){ 

        Write-NotationNote -Note $Content.Invoke() -Length $NoteLength
    
    }elseif($Midi){

        Set-CurrentTime -CurrentTime $MyInvocation.MyCommand.Name

        Foreach($Note in $Content){
            Write-MidiNote -Note $Content.Invoke() -Length $MyInvocation.MyCommand.Name
        }

        Write-MidiSleep -Length $MyInvocation.MyCommand.Name
        Write-MidiNoteOff 
        Clear-NoteOffMemory



    }else{
        return $Note
    }

    

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
Function Show-PHChordMidi {
    param(
        [Chord]$Chord,
        [int]$BPM
    )
    
    Ipmo C:\Users\Kevin\Downloads\PeteBrown.PowerShellMidi.dll

    Get-BPMValues -BOM $BPM



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
Function Song {
    param (
        $Content,
        $Name,
        $Path = $Home,
        [ValidateSet('Notation','Midi')]
        $OutputMode,
        $BPM
    )

    
Set-OutputMode -OutputMode $OutputMode

$Mode = Get-OutputMode 

Switch ($Mode) {
    "Notation" {$Notation = $true;$Midi =  $False}
    "Midi" {$Midi = $true;$Notation = $False}
}

if($Notation){
Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3

$ScriptContent = $Content.Invoke()

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        h1 "$($Name)"
        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

$Name = $Name + ".html"   
$Name = $Name.replace(" ","")

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML


}elseif($Midi){

    Clear-CurrentSong

    Out-MidiFile -String @'
    Import-Module PeteBrown.PowerShellMidi.dll -Force

    $Device = (Get-MidiOutputDeviceInformation | Where-Object {$_.name -eq "Midi"}).Id

    $Port = Get-MidiOutputPort -Id $Device    
'@

    Set-BPMValue -BPM $BPM

    $Content.Invoke()
}

}
Function Write-MidiNote {
    param(
        [Note[]]$Note,
        $Length,
        $Velocity
    )

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    $MidiJSON = (Get-Content $ModulePath\Facts\MidiMapping.json)
    $MidiObj = $MidiJSON | ConvertFrom-Json

    if($Note.count -gt 1){
        
    Foreach($Instance in $Note){
        $MidiNote = ($MidiObj | Where-Object {$_.letter -eq $Instance.Letter -and $_.Octave -eq $Instance.Octave}).MidiMapping 
        $ReturnString = @'
Send-MidiNoteOnMessage -Note {0} -Velocity 100 -Channel 0 -Port $Port
'@ -f $MidiNote

    $ReturnString | Out-File -FilePath $CurrentSong -Append

    $CurrentTime = Get-CurrentTime
    Write-MidiMemory -MidiNote $MidiNote -Length $CurrentTime
    Write-NoteOffMemory -MidiNote $MidiNote
        
    }

    }else{
    
    $MidiNote = ($MidiObj | Where-Object {$_.letter -eq $Note.Letter -and $_.Octave -eq $Note.Octave}).MidiMapping

    
    $ReturnString = @'
    Send-MidiNoteOnMessage -Note {0} -Velocity 100 -Channel 0 -Port $Port
'@ -f $MidiNote
     
    }
    $ReturnString | Out-File -FilePath $CurrentSong -Append
    $CurrentTime = Get-CurrentTime
    Write-MidiMemory -MidiNote $MidiNote -Length $CurrentTime
    Write-NoteOffMemory -MidiNote $MidiNote

}
Function Write-MidiNoteOff {

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $CurrentSong = "$ModulePath\MidiTemp\CurrentSong.ps1"

    $JSON = Get-Content $PSScriptRoot\Facts\NoteOffMemory.json 
    $Obj = $JSON | ConvertFrom-Json

    foreach($Note in $Obj.Notes){
        $ReturnString = @'
Send-MidiNoteOffMessage -Note {0} -Velocity 10 -Channel 0 -Port $Port
'@ -f $Note
    
    $ReturnString | Out-File -FilePath $CurrentSong -Append
}
}
Function Write-NotationNote {
    param(
        [Note[]]$Note,
        $Length
    )

    $CurrentClef = Get-Clef

    if($Note.count -gt 1){
        $ChordStringArr = @() 

    $Count = 0
    $AccidentalArr = @()
    
    Foreach($Instance in $Note){
        if($Instance.Letter -clike "*b*"){
            $AccidentalHash = @{
                Instance = $count
                Accidental = "b"
            }

            $AccidentalObj = New-Object psobject -property $AccidentalHash
            $AccidentalArr += $AccidentalObj
        }elseif($Instance.Letter -like "*#*"){
            $AccidentalHash = @{
                Instance = $count
                Accidental = "#"
            }

            $AccidentalObj = New-Object psobject -property $AccidentalHash
            $AccidentalArr += $AccidentalObj
        }
        $String = '"{0}/{1}"' -f $($Instance.Letter), $($Instance.Octave)
        $ChordStringArr += $String
        $count++
    }

    $ChordString = $ChordStringArr -join ", "

    if($AccidentalArr.count -eq 0){
        $ReturnString = @"
        new VF.StaveNote({clef: "$CurrentClef", keys: [$ChordString], duration: "$Length" })
"@
    }else{
        $AccidentalStrinArr = @()
        Foreach($Accindetal in $AccidentalArr){
            $Number = $Accindetal.Instance
            $Acc = $Accindetal.Accidental
            $AccidentalStrinArr +=  @"
        addAccidental($Number, new VF.Accidental("$Acc"))
"@
        }
        $ReturnString = @"
        new VF.StaveNote({clef: "$CurrentClef", keys: [$ChordString], duration: "$Length" }).
        $($AccidentalStrinArr -join ".`n")
"@
    }
    

    }else{
    
    $NoteString = "$($Note.Letter)/$($Note.Octave)"

    if($Note.Letter -clike "*b*"){
        $ReturnString = @"
new VF.StaveNote({clef: "$CurrentClef", keys: ["$NoteString"], duration: "$Length" }).
addAccidental(0, new VF.Accidental("b"))
"@
    }elseif($Note.Letter -like "*#*"){
    $ReturnString = @"
    new VF.StaveNote({clef: "$CurrentClef", keys: ["$NoteString"], duration: "$Length" }).
    addAccidental(0, new VF.Accidental("#"))
"@
    }else{

        if($Note.IsPause){
            $ReturnString = @"
        new VF.StaveNote({clef: "$CurrentClef", keys: ["$NoteString"], duration: "$($Length)r" })
"@
        }else{
        $ReturnString = @"
        new VF.StaveNote({clef: "$CurrentClef", keys: ["$NoteString"], duration: "$Length" })
"@
        }
    }
    
    }

    
    

    Return $ReturnString
}
