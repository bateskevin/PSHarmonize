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
