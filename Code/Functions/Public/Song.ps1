Function Song {
    param (
        $Content,
        $Name

    )

    
$Notation = $true

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

$Path = "C:\"
$Name = "index.html"    

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML


}

}