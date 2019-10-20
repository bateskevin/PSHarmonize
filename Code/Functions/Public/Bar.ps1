Function Bar {
    param (
        $Content,
        [Switch]$LastBar
    )

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

}
