Function Song {
    param (
        $Content,
        $Name,
        $Path = $Home,
        [ValidateSet('Notation','Midi')]
        $OutputMode,
        $BPM
    )

    
Set-OutputMode -OutputMode $OutputMode

$Mode = Get-OutputMode 

Switch ($Mode) {
    "Notation" {$Notation = $true;$Midi =  $False}
    "Midi" {$Midi = $true;$Notation = $False}
}

if($Notation){
Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3

$ScriptContent = $Content.Invoke()

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        h1 "$($Name)"
        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

$Name = $Name + ".html"   
$Name = $Name.replace(" ","")

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML


}elseif($Midi){

    Clear-CurrentSong

    Out-MidiFile -String @'
    Import-Module PeteBrown.PowerShellMidi.dll -Force

    $Device = (Get-MidiOutputDeviceInformation | Where-Object {$_.name -eq "Midi"}).Id

    $Port = Get-MidiOutputPort -Id $Device    
'@

    Set-BPMValue -BPM $BPM

    $Content.Invoke()
}

}
