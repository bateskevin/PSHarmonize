ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 16 -Label "Test" -Content {
        Bar {
            Minim {A;C#;E} 
            quaver {B} 
            quaver {A} 
            crotchet {C;E;G} 
        } 
        Bar {
            Minim {A;C#;E} 
            quaver {B} 
            quaver {A} 
            crotchet {C;E;G} 
        } 
        Bar {
            Minim {A;C#;E} 
            quaver {B} 
            quaver {A} 
            crotchet {C;E;G} 
        } 
        Bar {
            Minim {A;C#;E} 
            quaver {B} 
            quaver {A} 
            crotchet {C;E;G} 
        } -Last
    } 
} -Name "4 Bars" -Notation