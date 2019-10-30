ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song {
    Line -NumberOfBeats 4 -Label "Bethoven symphony No. 5" -Content {
         
        Bar {
            quaver {Pause}  
            quaver {G;G -octave 3} 
            quaver {G;G -octave 3} 
            quaver {G;G -octave 3} 
            Minim {E;E -octave 3}
       
            quaver {Pause}  
            quaver {F;F -octave 3} 
            quaver {F;F -octave 3} 
            quaver {F;F -octave 3} 
            Minim {D;D -octave 3} 
        
            Semibreve {D;D -octave 3}  
        
            Semibreve {D;D -octave 3}  
        } -last 
    } -TimeSignature "2/4" -Key "Eb" -Ties "9/0-10/0","9/1-10/1","10/0-11/0","10/1-11/1"
    Line -NumberOfBeats 4 -Label "Test" -Content {
         
        Bar {
            quaver {Pause -Octave 3}  
            quaver {G -octave 3;G -octave 2} 
            quaver {G -octave 3;G -octave 2} 
            quaver {G -octave 3;G -octave 2} 
            Minim {E -octave 3;E -octave 2} 
        
        
            quaver {Pause -octave 3}  
            quaver {F -octave 3;F -octave 2} 
            quaver {F -octave 3;F -octave 2} 
            quaver {F -octave 3;F -octave 2} 
            Minim {D -octave 3;D -octave 2} 
       
            Semibreve {D  -octave 3;D -octave 2}  
        
      
            Semibreve {D  -octave 3;D -octave 2}  
        } -Last
    } -Clef baritone-f -TimeSignature "2/4" -Key "Eb" -Ties "9/0-10/0","9/1-10/1","10/0-11/0","10/1-11/1"

    Line -NumberOfBeats 4 -Label "Bethoven symphony No. 5" -Content {
        Bar {
            quaver {Pause}  
            quaver {G}
            quaver {G}
            quaver {G} 
        
            quaver {Pause}  
            quaver {A}
            quaver {A}
            quaver {A} 
        
            quaver {Pause}  
            quaver {E -octave 5}
            quaver {E -octave 5}
            quaver {E -octave 5} 
        } -Last

    } -TimeSignature "2/4" -Key "Eb"
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Semibreve {Pause}  
        
            Semibreve {E -octave 3;G -octave 3} 
        
            Semibreve {E -octave 3;G -octave 3;B -octave 3}
        } -Last
    } -TimeSignature "2/4" -Key "Eb" -Ties "1/0-2/0","1/1-2/1"

    Line -NumberOfBeats 4 -Label "Bethoven symphony No. 5" -Content {
        Bar {
            semibreve {C -octave 5}
        
            quaver {C -octave 5}  
            quaver {G}
            quaver {G}
            quaver {G} 
        
            quaver {Pause}  
            quaver {A}
            quaver {A}
            quaver {A} 

            quaver {Pause}  
            quaver {F -octave 5}
            quaver {F -octave 5}
            quaver {F -octave 5}
             
        } -Last

    } -TimeSignature "2/4" -Key "Eb" -Ties "0/0-1/0"
    Line -NumberOfBeats 4 -Label "Test" -Content {
        Bar {
            Semibreve {C;E;G}  
        
            Semibreve {C;E;G}  

            Semibreve {B -octave 3;D} 
            
            Semibreve {B -octave 3;D;G} 

        } -Last
    } -TimeSignature "2/4" -Key "Eb" -Ties "0/0-1/0","0/1-1/1","0/2-1/2","1/0-2/0","1/1-2/1","2/0-3/0","2/1-3/1"

} -OutputMode Notation -Name "Bethoven symphony No. 5"