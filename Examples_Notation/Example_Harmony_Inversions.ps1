ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Minim {C -Chord Major7 -Inversion 1} 
            quaver {G -Chord Dominant7 -Inversion 3} 
            quaver {A -chord Dominant7 -Mood Minor -Inversion 2} 
            crotchet {F -Chord Major7 -Inversion 3}
        } -Last
    } 
} -Notation -Name "More Complex Chord Inversions" 