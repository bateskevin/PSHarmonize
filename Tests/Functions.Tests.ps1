Import-Module $PSScriptRoot\..\PSHarmonize\PSHarmonize.psd1 -Force

#. $PSScriptRoot\..\Code\Classes\1_Note.ps1

Import-Module Pester

Describe "[PSHarmonize][Functions] Testing General Functions" {

    $LetterArr = @({C},{C#},{Db},{D},{D#},{Eb},{E},{F},{F#},{Gb},{G},{G#},{Ab},{A},{A#},{Bb},{B})
    
    Context "[PSHarmonize][Functions][Get-PHChord]" {

        It "[PSHarmonize][Functions][Get-PHChord] Function without Parameters." {
            {Get-PHChord} | Should -Throw
        }

        Foreach($Letter in $LetterArr){

            Context "[PSHarmonize][Functions][Get-PHChord] Get-PHChord on $Letter" {
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Function without Mood." {
                    {Get-PHChord -Root $Letter.Tostring()} | Should -Throw
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Triad should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Major -type Triad).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHTriad $Letter.Tostring() -Mood Major).Letter
                    $Compare | Should -Be $null 
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Triad should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Minor -type Triad).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHTriad $Letter.Tostring() -Mood Minor).Letter
                    $Compare | Should -Be $null
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Dominant7 should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Major -type Dominant7).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHDominant7 $Letter.Tostring() -Mood Major).Letter
                    $Compare | Should -Be $null
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Dominant7 should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Minor -type Dominant7).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHDominant7 $Letter.Tostring() -Mood Minor).Letter
                    $Compare | Should -Be $null
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Major Major7 should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Major -type Major7).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHMajor7 $Letter.Tostring() -Mood Major).Letter
                    $Compare | Should -Be $null
                }
        
                It "[PSHarmonize][Functions][Get-PHChord] $Letter Minor Major7 should not throw." {
                    $Notes = (Get-PHChord -Root $Letter.Tostring() -Mood Minor -type Major7).Notes
                    $Compare = Compare-Object -ReferenceObject $Notes.Letter -DifferenceObject (Get-PHMajor7 $Letter.Tostring() -Mood Minor).Letter
                    $Compare | Should -Be $null
                }
            }
        }   
    }

    Context "[PSHarmonize][Functions][Get-PHChordProgression]" {
        
        It "[PSHarmonize][Functions][Get-PHChordProgression] Should Throw without Parameters." {
            {Get-PHChordProgression} | Should -Throw
        } 

        It "[PSHarmonize][Functions][Get-PHChordProgression] Should Throw without Root." {
            {Get-PHChordProgression -Numbers 1,5,6,4} | Should -Throw
        } 

        Foreach($Letter in $LetterArr){
            Context "[PSHarmonize][Functions][Get-PHChordProgression] ChordProgression for $Letter should Contain the right Chords." {
                $ChordProgression = Get-PHChordProgression -Root $Letter.ToString() -Numbers 1,5,6,4
                $Count = 0
                Foreach($ChordName in $ChordProgression.Chords.Chordname){
                    It "[PSHarmonize][Functions][Get-PHChordProgression] Numeral $Count of ChordProgression should be of the Correct Mood" {
                        if($Count -ne 2){
                            $Chordname | Should -BeLike "*MajorTriad"
                        }else{
                            $Chordname | Should -BeLike "*MinorTriad"
                        }
                    }
                    $Count++
                }
            }
        }
    }

    
}