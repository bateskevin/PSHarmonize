

Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3

$ScriptContent =  @"
           
 




VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 1000,
    canvasHeight: 300
};

// Create a renderer with SVG
var renderer = new VF.Renderer(
    WorkspaceInformation.div,
    VF.Renderer.Backends.SVG
);

// Use the renderer to give the dimensions to the SVG
renderer.resize(WorkspaceInformation.canvasWidth, WorkspaceInformation.canvasHeight);

// Expose the context of the renderer
var context = renderer.getContext();

// And give some style to our SVG
context.setFont("Arial", 10, "").setBackgroundFillStyle("#eed");


/**
 * Creating a new stave
 */
// Create a stave of width 400 at position x10, y40 on the SVG.
var stave = new VF.Stave(10, 40, 800);
// Add a clef and time signature.
stave.addClef("treble").addTimeSignature("4/4");
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();

var notes = [


    new VF.StaveNote({clef: "treble", keys: ["A/3", "C#/3", "E/3"], duration: "2" }),
 new VF.StaveNote({clef: "treble", keys: ["B/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["A/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["C/3", "E/3", "G/3"], duration: "4" }),

 

    new VF.StaveNote({clef: "treble", keys: ["A/3", "C#/3", "E/3"], duration: "2" }),
 new VF.StaveNote({clef: "treble", keys: ["B/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["A/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["C/3", "E/3", "G/3"], duration: "4" }),

 

    new VF.StaveNote({clef: "treble", keys: ["A/3", "C#/3", "E/3"], duration: "2" }),
 new VF.StaveNote({clef: "treble", keys: ["B/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["A/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["C/3", "E/3", "G/3"], duration: "4" }),

 

    new VF.StaveNote({clef: "treble", keys: ["A/3", "C#/3", "E/3"], duration: "2" }),
 new VF.StaveNote({clef: "treble", keys: ["B/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["A/3"], duration: "8" }),
 new VF.StaveNote({clef: "treble", keys: ["C/3", "E/3", "G/3"], duration: "4" })


];

// Create a voice in 4/4 and add above notes
var Test = new VF.Voice({num_beats: 16,  beat_value: 4});
Test.addTickables(notes);

// Format and justify the notes to 400 pixels.
var formatter = new VF.Formatter().joinVoices([Test]).format([Test], 750);

// Render voice
Test.draw(context, stave);


"@

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        h1 "$($Chord.ChordName)"
        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

$Path = "C:\"
$Name = "index.html"    

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML


