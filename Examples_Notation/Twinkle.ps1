ipmo .\PSHarmonize\PSHarmonize.psd1 -Force 

Song -Name "Twinkle Twinkle little Star" {
    Line -NumberOfBeats 16 -Label "Line1" -Content {
        Bar {
            crotchet {C} 
            crotchet {C} 
            crotchet {G} 
            crotchet {G} 
        } 
        Bar {
            crotchet {A} 
            crotchet {A} 
            Minim {G} 
        } 
        Bar {
            crotchet {F} 
            crotchet {F} 
            crotchet {E} 
            crotchet {E} 
        }  
        Bar {
            crotchet {D} 
            crotchet {D} 
            Minim {C} 
        }  -Last
    } 

    Line -NumberOfBeats 16 -Label "Line2" -Content {
        Bar {
            crotchet {G} 
            crotchet {G} 
            crotchet {F} 
            crotchet {F} 
        } 
        Bar {
            crotchet {E} 
            crotchet {E} 
            Minim {D} 
        } 
        Bar {
            crotchet {G} 
            crotchet {G} 
            crotchet {F} 
            crotchet {F} 
        } 
        Bar {
            crotchet {E} 
            crotchet {E} 
            Minim {D} 
        }  -Last
    }
    Line -NumberOfBeats 16 -Label "Line1" -Content {
        Bar {
            crotchet {C} 
            crotchet {C} 
            crotchet {G} 
            crotchet {G} 
        } 
        Bar {
            crotchet {A} 
            crotchet {A} 
            Minim {G} 
        } 
        Bar {
            crotchet {F} 
            crotchet {F} 
            crotchet {E} 
            crotchet {E} 
        }  
        Bar {
            crotchet {D} 
            crotchet {D} 
            Minim {C} 
        }  -Last
    } 
} -OutputMode Notation  