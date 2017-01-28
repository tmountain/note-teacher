function drawNote(elementID, note, clef)
{
    const VF = Vex.Flow;
    document.getElementById(elementID).innerHTML = "";

    var vf = new Vex.Flow.Factory({
        renderer: {selector: elementID, width: 250, height: 300}
    });

    var score = vf.EasyScore();
    var system = vf.System();

    /*
    tokens = note.split("");
    tokens[1] = Math.floor((Math.random() * 4) + 3);
    note = tokens.join("");
    */

    system.addStave({
        voices: [
        score.voice(score.notes(note, {stem: 'up'})),
        ]
    }).addClef('treble').addTimeSignature('4/4');

    tokens = note.split("");
    tokens[1] = tokens[1] - 1;
    note = tokens.join("")

    system.addStave({
        voices: [
        score.voice(score.notes(note, {clef: 'bass', stem: 'up'})),
        ]
    }).addClef('bass').addTimeSignature('4/4');

    system.addConnector();
    vf.draw();
}
