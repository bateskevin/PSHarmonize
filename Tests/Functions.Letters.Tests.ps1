Import-Module $PSScriptRoot\..\PSHarmonize\PSHarmonize.psd1 -Force

#. $PSScriptRoot\..\Code\Classes\1_Note.ps1

Import-Module Pester

Describe "[PSHarmonize][Functions] Testing Letter Functions" {

    $LetterArr = @({C},{C#},{Db},{D},{D#},{Eb},{E},{F},{F#},{Gb},{G},{G#},{Ab},{A},{A#},{Bb},{B})

    Foreach($Letter in $LetterArr){
        Context "[PSHarmonize][Functions][Letter] $Letter Without Parameters."{
            it "The Function for $Letter should not throw without Parameters." {
                {$Letter.Invoke()} | Should -not -Throw
            }

            $Note = $Letter.Invoke()

            Foreach($Property in ($Note | gm | ? {$_.Membertype -eq "Property"}).Name){
                it "$Letter should Contain the Correct Property for '$Property' without any Parameters" {

                    $ModulePath = (Split-Path (Get-Module PSHarmonize).Path)
                    $JSON = (Get-Content $ModulePath\Facts\NoteMapping.json)
                    $NoteMappingObj = $JSON | ConvertFrom-Json

                    Switch ($Property) {
                        "EnharmonicFlavour" {"","#","b" | Should -Contain $Note.$Property}
                        "Length" {$Note.$Property | Should -Be "semibreve"}
                        "Letter" {$Note.$Property | Should -BeExactly $Letter.ToString()}
                        "NoteMapping" {$Note.$Property | Should -BeExactly ($NoteMappingObj | Where-Object {$_.Letter -eq $Letter.ToString()}).NoteMapping}               
                        "Numeral" {$Note.$Property | Should -Be 0}
                        "Octave" {$Note.$Property | should -Be 4}
                        "Velocity" {$Note.$Property | Should -Be 0}  
                    }
                }
            }
        }

        Context "[PSHarmonize][Functions][Letter] $Letter Wit Parameters." {
            It "[PSHarmonize][Functions][Letter] Octave should be assignable" {
                $Note = Invoke-expression "$($Letter.Tostring()) -Octave 3"
                $Note.octave | Should -Be 3
            }

            It "[PSHarmonize][Functions][Letter] Octave should be assignable" {
                $Note = Invoke-expression "$($Letter.Tostring()) -Octave 3"
                $Note.octave | Should -Be 3
            }
        }

        Context "[PSHarmonize][Functions][Letter] Chords of $Letter" {
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Triad should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Triad -Mood Major"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHTriad $Letter.Tostring() -Mood Major).Letter
                $Compare | Should -Be $null 
            }
    
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Triad should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Triad -Mood Minor"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHTriad $Letter.Tostring() -Mood Minor).Letter
                $Compare | Should -Be $null
            }
    
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Dominant7 should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Dominant7 -Mood Major"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHDominant7 $Letter.Tostring() -Mood Major).Letter
                $Compare | Should -Be $null
            }
    
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Dominant7 should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Dominant7 -Mood Minor"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHDominant7 $Letter.Tostring() -Mood Minor).Letter
                $Compare | Should -Be $null
            }
    
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Major7 should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Major7 -Mood Major"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHMajor7 $Letter.Tostring() -Mood Major).Letter
                $Compare | Should -Be $null
            }
    
            It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Major7 should not throw." {
                $Notes = invoke-expression "$($Letter.ToString()) -Chord Major7 -Mood Minor"
                $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHMajor7 $Letter.Tostring() -Mood Minor).Letter
                $Compare | Should -Be $null
            }
        }
    }
}