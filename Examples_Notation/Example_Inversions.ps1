ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Minim {C -Chord triad -Inversion 1} 
            quaver {G -Chord triad} 
            quaver {A -chord Triad -Mood Minor} 
            crotchet {F -Chord Triad -Inversion 2}
        } -Last
    } 
} -OutputMode Notation -Name "Triad Inversions"