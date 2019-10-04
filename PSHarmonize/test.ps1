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

$MoodArr = @()

$MoodHash = [ordered]@{
    RomanNumeral = 1
    Mood = "Major"
} 

$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 2
    Mood = "Minor"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 3
    Mood = "Minor"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 4
    Mood = "Major"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 5
    Mood = "Major"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 6
    Mood = "Minor"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj

$MoodHash = [ordered]@{
    RomanNumeral = 7
    Mood = "Minor"
} 
$Moodobj = new-object psobject -Property $MoodHash
$MoodArr += $Moodobj



$MoodArr | ConvertTo-Json


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