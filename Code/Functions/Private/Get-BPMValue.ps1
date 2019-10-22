Function Get-BPMValue {
    $BPMValue = Get-Content $PSScriptRoot\Facts\CurrentBPM.json | Convertfrom-Json

    return $BPMValue.BPM
}