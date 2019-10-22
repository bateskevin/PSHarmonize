Function Set-CurrentTime {
    param(
        $CurrentTime
    )


    $JSON = Get-Content $PSScriptRoot\Facts\CurrentTime.json 
    $Obj = $JSON | ConvertFrom-Json

    $Obj.CurrentTime = $CurrentTime

    $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentTime.json

}