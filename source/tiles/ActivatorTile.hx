package tiles;

import music.NoteManager;
import music.NoteManager.NoteLengthType;
import flixel.FlxG;

class ActivatorTile extends Tile {

    public var start:Bool = true;
    public var noteLength:NoteLengthType;

    public function new(Tilemap:MapController, Index:Int, NoteLength:NoteLengthType=NoteLengthType.Quarter) {
        super(Tilemap, Index);

        noteLength = NoteManager.getRandomNoteLengthType(); 
    }

    public override function getTileType() {
        return 1;
    }

    public function tryStart(beat:Int) {
        if (!start || beat % cast(noteLength, Int) != 0)
            return;

        start = false;

        var neighbors = getNeighbors();

        var pd = new PropagateData(this, tilemap.length(), noteLength);
        for(tile in neighbors) {
            tile.setActivate(pd, false);
        }
    }
}