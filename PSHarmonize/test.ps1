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

$NoteHash = [ordered]@{
    Line = 19
    Mood = "Eb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 19
    Mood = "E"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 18
    Mood = "F"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 18
    Mood = "F#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 17
    Mood = "Gb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 17
    Mood = "G"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 17
    Mood = "G#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 16
    Mood = "Ab"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 16
    Mood = "A"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 16
    Mood = "A#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 15
    Mood = "Bb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 15
    Mood = "B"
    Addition = $null
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 14
    Mood = "C"
    Addition = $null
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 14
    Mood = "C#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 13
    Mood = "Db"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 13
    Mood = "D"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 13
    Mood = "D#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 12
    Mood = "Eb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 12
    Mood = "E"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 12
    Mood = "E#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 11
    Mood = "F"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 11
    Mood = "F#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 10
    Mood = "Gb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 10
    Mood = "G"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 10
    Mood = "G#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 9
    Mood = "Ab"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 9
    Mood = "A"
    Addition = ""
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 9
    Mood = "A#"
    Addition = "#"
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 8
    Mood = "Bb"
    Addition = "b"
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 8
    Mood = "B"
    Addition = ""
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 7
    Mood = "C"
    Addition = ""
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 7
    Mood = "c#"
    Addition = "#"
} 
$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 6
    Mood = "Db"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 6
    Mood = "D"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 6
    Mood = "D#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 5
    Mood = "Eb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 5
    Mood = "E"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj


$NoteHash = [ordered]@{
    Line = 4
    Mood = "F"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 4
    Mood = "F#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 3
    Mood = "Gb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 3
    Mood = "G"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 3
    Mood = "G#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 2
    Mood = "Ab#"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 2
    Mood = "A"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 2
    Mood = "A#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 1
    Mood = "Bb"
    Addition = "b"
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 1
    Mood = "B"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 0
    Mood = "C"
    Addition = ""
} 

$Moodobj = new-object psobject -Property $NoteHash
$MoodArr += $Moodobj

$NoteHash = [ordered]@{
    Line = 0
    Mood = "C#"
    Addition = "#"
} 

$Moodobj = new-object psobject -Property $NoteHash
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