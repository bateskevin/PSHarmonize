Function Show-PHChordProgression {
    param(
        [ChordProgression]$ChordProgression
    )
    
    $ChordProgression.Show()

    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)

    $Content = Get-Content "$ModulePath\Style\$($ChordProgression.Key.Letter)$($ChordProgression.Numbers).txt"

        Foreach($Line in $Content){
            $Line
        }

    $ChildItem = Get-ChildItem $ModulePath\Style\ | Where-Object {$_.Name -notlike "*template.txt"}

    $null = $ChildItem.FullName | Remove-Item -Force

}