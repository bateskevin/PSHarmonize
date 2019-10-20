Function Line {
    param (
        $Content,
        [int]$NumberOfBeats,
        $Label
    )

    $ContentArr = @()

    Foreach($Line in $Content){
        $LineContent = $Line.Invoke()
        $ContentArr += $LineContent
    }

    $VarNotes = $ContentArr -join ", "

    $Bar = @"

    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 850,
    canvasHeight: 200
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
$($Content.Invoke())
];

// Create a voice in 4/4 and add above notes
var $Label = new VF.Voice({num_beats: $NumberOfBeats,  beat_value: 4});
$Label.addTickables(notes);

// Format and justify the notes to 400 pixels.
var formatter = new VF.Formatter().joinVoices([$Label]).format([$Label], 750);

// Render voice
$Label.draw(context, stave);

"@

    Return $Bar

}
