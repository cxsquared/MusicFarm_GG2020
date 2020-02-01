package tiles;

import flixel.FlxG;

class ActivatorTile extends Tile {

    public var start:Bool = true;
    public var noteLength = 1;

    public function new(Tilemap:MapController, Index:Int) {
        super(Tilemap, Index);

        //TODO:Remove this once we get placement stuff
        noteLength = FlxG.random.int(1, 4); 

        tileType = 1;
    }

    public function tryStart(beat:Int) {
        if (!start || beat % noteLength != 0)
            return;

        FlxG.log.add("Starting activator " + id);

        start = false;

        var neighbors = getNeighbors();

        var pd = new PropagateData(this, tilemap.length());
        for(tile in neighbors) {
            tile.setActivate(pd, false);
        }
    }
}