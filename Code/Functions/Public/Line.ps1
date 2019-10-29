Function Line {
    param (
        $Content,
        [int]$NumberOfBeats,
        $Label,
        [ValidateSet('treble','baritone-f')]
        $Clef = "treble",
        [String[]]$Ties,
        [String]$TimeSignature = "4/4",
        [String]$Key = "C"
    )

    $Mode = Get-OutputMode

    Switch ($Mode) {
        "Notation" {$Notation = $true;$Midi=  $False}
        "Midi" {$Midi = $true;$Notation = $False}
    }

    If($notation){
        Set-Clef $Clef
    $CurrentClef = Get-Clef

    $ContentArr = @()

    Foreach($Line in $Content){
        $LineContent = $Line.Invoke()
        $ContentArr += $LineContent
    }

    $VarNotes = $ContentArr -join ", "

    if($Ties){
        $TieArr = @()

    Foreach($String in $Ties){

        $Split = $String.Split("-")

        $FirstNoteBeat = $Split[0].Split("/")[0]
        $FirstNoteHeight = $Split[0].Split("/")[1]
        $TieNoteBeat = $Split[1].Split("/")[0]
        $TieNoteHight = $Split[1].Split("/")[1]

        $Tie = @"
    new VF.StaveTie({
        first_note: notes[$FirstNoteBeat],
        last_note: notes[$TieNoteBeat],
        first_indices: [$FirstNoteHeight],
        last_indices: [$TieNoteHight]
      })    
"@

      $TieArr += $Tie

    }


    $TieContainer =@"

    var ties = [
        
$($tieArr -join ",`n")

      ];
      ties.forEach(function(t) {t.setContext(context).draw()})


"@ 

    }

    

    

    $Bar = @"

    VF = Vex.Flow;

// We created an object to store the information about the workspace
var WorkspaceInformation = {
    // The div in which you're going to work
    div: document.getElementById("some-div-id"),
    // Vex creates a svg with specific dimensions
    canvasWidth: 850,
    canvasHeight: 135
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
stave.addClef("$CurrentClef").addTimeSignature("$TimeSignature").addKeySignature("$key");
// stave.addModifier(keySig);
// Set the context of the stave our previous exposed context and execute the method draw !
stave.setContext(context).draw();

var notes = [
$($Content.Invoke())
];

// Create a voice in 4/4 and add above notes
//var $Label = new VF.Voice({num_beats: $NumberOfBeats,  beat_value: 4});
//$Label.addTickables(notes);

var beams = VF.Beam.generateBeams(notes);
VF.Formatter.FormatAndDraw(context, stave, notes);
beams.forEach(function(b) {b.setContext(context).draw()})

$TieContainer

// Format and justify the notes to 400 pixels.
//var formatter = new VF.Formatter().joinVoices([$Label]).format([$Label], 750);

// Render voice
//$Label.draw(context, stave);

"@
write-host "your key is: $key"
    Return $Bar
    }elseif($Midi){
        $Content.Invoke()
    }

    

}
