Function Set-BPMValue {
    param(
        $BPM
    )


    $JSON = Get-Content $PSScriptRoot\Facts\CurrentBPM.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.BPM = $BPM

    $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentBPM.json

}