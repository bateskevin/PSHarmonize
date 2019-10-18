
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

    Play(){

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