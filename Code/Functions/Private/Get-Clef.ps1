Function Get-Clef {
    $Clef = Get-Content $PSScriptRoot\Facts\CurrentClef.json | Convertfrom-Json

    return $Clef.Clef
}