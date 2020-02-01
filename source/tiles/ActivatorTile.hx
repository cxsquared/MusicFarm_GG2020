package tiles;

import flixel.FlxG;

class ActivatorTile extends Tile {

    public var start:Bool = true;

    public function new(Tilemap:MapController, Index:Int) {
        super(Tilemap, Index);

        tileType = 1;
    }

    public function tryStart() {
        if (!start)
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