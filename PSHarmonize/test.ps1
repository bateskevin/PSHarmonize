ipmo .\psharmonize.psm1 -Force

$Root = [Note]::new("F")

$Triad = Get-PHTriad C Major

$Dominant = Get-PHDominant C Major

$Scale = Get-PHScale C Major

<#
$Triad = [Triad]::new($Root,"Minor")

$Triad.Notes

$Dominant = [Dominant]::new($Root,"Minor")

$Dominant.Notes

$Scale = $null

$Scale = [Scale]::new($Root,"Major")

$Scale.Notes

($Scale.Notes | Sort-Object -Property @{Expression = {$_.Octave}; Ascending = $true}, NoteMapping)
#>