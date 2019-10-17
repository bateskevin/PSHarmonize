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