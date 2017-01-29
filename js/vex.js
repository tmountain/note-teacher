function drawNote(elementID, note, clef)
{
    const VF = Vex.Flow;
    document.getElementById(elementID).innerHTML = "";

    var vf = new Vex.Flow.Factory({
        renderer: {selector: elementID, width: 250, height: 300}
    });

    var score = vf.EasyScore();
    var system = vf.System();
    var voice = score.voice([]); // used for empty voice
    voice.setStrict(false);

    if (clef == 'bass') {
        system.addStave({
            voices: [ voice ]
        }).addClef('treble').addTimeSignature('4/4');
    } else {
        system.addStave({
            voices: [
                score.voice(score.notes(note, {stem: 'up'})),
            ]
        }).addClef('treble').addTimeSignature('4/4');
    }

    tokens = note.split("");
    tokens[1] = tokens[1] - 1;
    note = tokens.join("")

    if (clef == 'treble') {
        system.addStave({
            voices: [ voice ]
        }).addClef('bass').addTimeSignature('4/4');
    } else {
        system.addStave({
            voices: [
                score.voice(score.notes(note, {stem: 'up'})),
            ]
        }).addClef('bass').addTimeSignature('4/4');
    }

    system.addConnector();
    vf.draw();
}
