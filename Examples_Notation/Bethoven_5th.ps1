ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Bethoven symphony No. 5" -Content {
         
        Bar {
            Minim {A -octave 3;C#;E} 
            quaver {C} 
            quaver {Pause} 
            crotchet {C;E;G} 
        } -Last
    }
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            Minim {A -octave 2;A -octave 3} 
            quaver {C -octave 2} 
            quaver {A -octave 2;A -octave 3} 
            crotchet {Pause -octave 3} 
        } -Last
    } -Clef baritone-f
} -OutputMode Notation -Name "One Bar with a Baseline"