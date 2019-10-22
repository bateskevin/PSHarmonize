Function Write-NotationNote {
    param(
        [Note[]]$Note,
        $Length
    )

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
        new VF.StaveNote({clef: "treble", keys: [$ChordString], duration: "$Length" })
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
        new VF.StaveNote({clef: "treble", keys: [$ChordString], duration: "$Length" }).
        $($AccidentalStrinArr -join ".`n")
"@
    }
    

    }else{
    
    $NoteString = "$($Note.Letter)/$($Note.Octave)"

    if($Note.Letter -clike "*b*"){
        $ReturnString = @"
new VF.StaveNote({clef: "treble", keys: ["$NoteString"], duration: "$Length" }).
addAccidental(0, new VF.Accidental("b"))
"@
    }elseif($Note.Letter -like "*#*"){
    $ReturnString = @"
    new VF.StaveNote({clef: "treble", keys: ["$NoteString"], duration: "$Length" }).
    addAccidental(0, new VF.Accidental("#"))
"@
    }else{
        $ReturnString = @"
        new VF.StaveNote({clef: "treble", keys: ["$NoteString"], duration: "$Length" })
"@
    }
    
    }

    
    

    Return $ReturnString
}