Function Show-PHChordProgressionHTML {

    param (
        [CHordprogression]$CHordprogression,
        $Path = $PSScriptRoot,
        $Name = "index.html"
    )

#ipmo .\PSHarmonize\PSHarmonize\PSHarmonize.psd1 -Force

Import-Module PSHTML -Force 

#$CHordprogression = Get-PHChordProgression -Root C -Numbers 1,5,6,3




    $ChordArr = @()
    
    foreach($Chord in $CHordprogression.Chords){
        #// A C-Major chord.
        $Output = @"
new VF.StaveNote({clef: "treble", keys: ["$($CHord.NOtes[0].Letter)/$($CHord.Notes[0].Octave)", "$($CHord.NOtes[1].Letter)/$($CHord.Notes[1].Octave)", "$($CHord.NOtes[2].Letter)/$($CHord.Notes[2].Octave)"], duration: "q" })
"@ 
        $ChordArr += $Output
    }


$ScriptContent =  @"
           
    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 500,
    canvasHeight: 500
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
var stave = new VF.Stave(10, 40, 400);
// Add a clef and time signature.
stave.addClef("treble").addTimeSignature("4/4");
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();


/**
* Draw notes
 */

var notes = [
    // A C-Major chord.
 $($ChordArr -join ",")
    
];

// Create a voice in 4/4 and add above notes
var voice = new VF.Voice({num_beats: 4,  beat_value: 4});
voice.addTickables(notes);

// Format and justify the notes to 400 pixels.
var formatter = new VF.Formatter().joinVoices([voice]).format([voice], 400);

// Render voice
voice.draw(context, stave);

"@

$Script = script -content {
          $ScriptContent
        } 

$HTML = html {

    head {
        script -src "https://unpkg.com/vexflow/releases/vexflow-min.js" -type text/javascript
    }

    body {

        div {

        } -id "some-div-id"
        $Script        
         
        
    }

    footer {
        p {"Copyright 2019"}
    }
        
}

Out-PSHTMLDocument -Show  -OutPath (Join-Path $Path $Name) -HTMLDocument $HTML

}
