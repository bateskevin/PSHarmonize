ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            Minim {A -octave 3;C#;E} 
            quaver {C} 
            quaver {A} 
            crotchet {C;E;G} 
        } -Last
    } -ties "0/0-1/0"
} -OutputMode Notation -Name "One Bar with ties"