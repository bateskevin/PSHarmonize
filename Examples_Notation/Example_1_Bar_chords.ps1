ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Minim {C -Chord triad -octave 4} 
            quaver {G -Chord triad -octave 4} 
            quaver {A -chord Dominant7 -Mood Minor -octave 4} 
            crotchet {F -Chord Major7 -octave 4}
        } -Last
    } 
} -Notation -Name "One Bar"