function initVex(divRoot) {
    // Handler when the DOM is fully loaded
    VF = Vex.Flow;

    // Create an SVG renderer and attach it to the DIV element named "boo".
    var div = document.getElementById(divRoot);
    var renderer = new VF.Renderer(div, VF.Renderer.Backends.SVG);

    // Configure the rendering context.
    renderer.resize(500, 500);
    var context = renderer.getContext();
    context.setFont("Arial", 10, "").setBackgroundFillStyle("#eed");

    // Create a stave of width 400 at position 10, 40 on the canvas.
    var stave = new VF.Stave(10, 40, 200);

    // Add a clef and time signature.
    stave.addClef("treble");

    // Connect it to the rendering context and draw!
    stave.setContext(context).draw();

    // Render voice
    drawNote("c/4").draw(context, stave);
}

function drawNote(note) {
    // Create the notes
    var notes = [
        // A quarter-note C.
        new VF.StaveNote({
            keys: ["c/4"],
            duration: "w"
        }),
    ];

    // Create a voice in 4/4 and add above notes
    var voice = new VF.Voice({
        num_beats: 4,
        beat_value: 4
    });
    voice.addTickables(notes);

    // Format and justify the notes to 400 pixels.
    new VF.Formatter().joinVoices([voice]).format([voice], 400);
    return voice;
}
