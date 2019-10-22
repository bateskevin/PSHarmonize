ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Minim {C -Chord triad} 
            quaver {G -Chord triad} 
            quaver {A -chord Dominant7 -Mood Minor} 
            crotchet {F -Chord Major7}
        } -Last
    } 
} -OutputMode Notation -Name "One Bar of Chords"