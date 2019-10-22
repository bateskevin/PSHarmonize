Function Get-CurrentTime {
    $CurrentTime = Get-Content $PSScriptRoot\Facts\CurrentTime.json | Convertfrom-Json

    return $CurrentTime.CurrentTime
}