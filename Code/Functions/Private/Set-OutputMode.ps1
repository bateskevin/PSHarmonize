Function Set-OutPutMode {
    param(
        [ValidateSet('Notation','Midi')]
        $OutputMode
    )

    

    Switch ($Outputmode) {
        "Notation" {
            $JSON = Get-Content $PSScriptRoot\Facts\OutPutMode.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.OutputMode = "Notation"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\OutPutMode.json
        }
        "Midi" {
            $JSON = Get-Content $PSScriptRoot\Facts\OutPutMode.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.OutputMode = "Midi"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\OutPutMode.json
        }
    }
}