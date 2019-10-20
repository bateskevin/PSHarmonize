Function Get-NoteLength {
    param(
        [Length]$Length,
        [Switch]$Midi
    )

    $Notation = $true

    If($Notation){
        Switch ($Length) {
            "Semibreve" {$NoteLength = 1}
            "Minim" {$NoteLength = 2}
            "Crotchet" {$NoteLength = 4}
            "Quaver" {$NoteLength = 8}
            "Semiquaver" {$NoteLength = 16}
        }
    }elseif($Midi){

    }
    
    Return $NoteLength 

}