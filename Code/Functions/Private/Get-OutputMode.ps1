Function Get-OutPutMode {
    $OutputMode = Get-Content $PSScriptRoot\Facts\OutPutMode.json | Convertfrom-Json

    return $OutputMode.OutputMode
}