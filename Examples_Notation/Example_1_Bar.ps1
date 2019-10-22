ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            Minim {A;C#;E} 
            quaver {B} 
            quaver {A} 
            crotchet {C;E;G} 
        } -Last
    } 
} -OutputMode Notation -Name "One Bar"