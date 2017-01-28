function drawNote(elementID, note, clef)
{
    const VF = Vex.Flow;
    document.getElementById(elementID).innerHTML = "";

    var vf = new Vex.Flow.Factory({
        renderer: {selector: elementID, width: 200, height: 200}
    });

    var score = vf.EasyScore();
    var system = vf.System();

    system.addStave({
        voices: [
        score.voice(score.notes(note, {stem: 'up'})),
        ]
    }).addClef(clef).addTimeSignature('4/4');

    vf.draw();
}
