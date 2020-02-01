package tiles;

import flixel.tile.FlxTilemap;
import flixel.group.FlxGroup;

class PropagateData {

    public var origin:ActivatorTile;
    public var totalTiles:Int;
    private var tilesSeen = new Map<Int, Tile>();
    public var length = 0;

    public function new(Origin:ActivatorTile, TotalTiles:Int) {
        totalTiles = TotalTiles;
        origin = Origin;

        add(origin);
    }

    public function add(tile:Tile) {
        tilesSeen.set(tile.id, tile);
        length++;
    }

    public function contains(tile:Tile):Bool {
        return tilesSeen.exists(tile.id);
    }

    public function checkFinished() {
        if (length == totalTiles) {
            origin.start = true;
        }
    }
}