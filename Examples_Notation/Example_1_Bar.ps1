ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            Minim {Ab;C#;Eb} 
            quaver {C} 
            quaver {A} 
            crotchet {C#;E;G#} 
        } -Last
    } 
} -OutputMode Notation -Name "One Bar"