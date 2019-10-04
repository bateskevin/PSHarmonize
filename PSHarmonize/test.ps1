ipmo .\psharmonize.psm1 -Force

$Root = [Note]::new("F")

$Triad = Get-PHTriad C Major

$Dominant7 = Get-PHDominant7 C Major

$Scale = Get-PHScale C Major

write-host "Triad:" -ForegroundColor Yellow
$Triad
write-host "Dominant7:" -ForegroundColor Yellow
$Dominant7
write-host "Scale:" -ForegroundColor Yellow
$Scale

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