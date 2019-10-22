ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            Minim {A -Chord Triad -Mood Major} 
            Minim {A}
        } -Last
    }
} -OutputMode Midi -Name "One Bar" -BPM 60