package tiles;

import music.NoteManager;
import music.NoteManager.NoteLengthType;

class PropagateData {

    public var origin:ActivatorTile;
    public var totalTiles:Int;
    private var tilesSeen = new Map<Int, Tile>();
    public var length = 0;
    public var finished:Bool = false;
    public var noteLength:NoteLengthType;

    public function new(Origin:ActivatorTile, TotalTiles:Int, NoteLength:NoteLengthType = NoteLengthType.Quarter) {
        totalTiles = TotalTiles;
        origin = Origin;
        noteLength = NoteLength;

        add(origin);
    }

    public function add(tile:Tile) {
        tilesSeen.set(tile.id, tile);
        length++;
    }

    public function shouldPropagate(beat:Int) {
        return beat % cast(noteLength, Int) == 0;
    }

    public function contains(tile:Tile):Bool {
        return tilesSeen.exists(tile.id);
    }

    public function checkFinished() {
        if (length == totalTiles && !finished) {
            if (origin != null) {
                origin.start = true;
            }
            finished = true;
        }
    }
}