Function Write-NotationNote {
    param(
        [Note[]]$Note,
        $Length
    )

    if($Note.count -gt 1){
        $ChordStringArr = @() 

    Foreach($Instance in $Note){
        $String = '"{0}/{1}"' -f $($Instance.Letter), $($Instance.Octave)
        $ChordStringArr += $String
    }

    $ChordString = $ChordStringArr -join ", "

    $ReturnString = @"
new VF.StaveNote({clef: "treble", keys: [$ChordString], duration: "$Length" })
"@

    }else{
        $NoteString = "$($Note.Letter)/$($Note.Octave)"

    $ReturnString = @"
new VF.StaveNote({clef: "treble", keys: ["$NoteString"], duration: "$Length" })
"@
    }

    
    

    Return $ReturnString
}