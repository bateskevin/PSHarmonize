Function Set-Clef {
    param(
        [ValidateSet('treble','baritone-f')]
        $Clef
    )

    

    Switch ($clef) {
        "treble" {
            $JSON = Get-Content $PSScriptRoot\Facts\CurrentClef.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.Clef = "treble"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentClef.json
        }
        "baritone-f" {
            $JSON = Get-Content $PSScriptRoot\Facts\CurrentClef.json 
            $Obj = $JSON | ConvertFrom-Json
        
            $Obj.Clef = "baritone-f"

            $Obj | ConvertTo-JSON | Out-File -FilePath $PSScriptRoot\Facts\CurrentClef.json
        }
    }
}