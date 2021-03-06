package tiles;

import flixel.math.FlxMath;
import flixel.FlxG;

class Tile {
    public static var lastUsedId = 0;

    public var id:Int;
    public var delayActivate:Bool = false;

    public var propagations = new Array<PropagateData>();
    public var tilemap:MapController;
    public var index:Int;

    public function new(Tilemap:MapController, Index:Int) {
        tilemap = Tilemap;
        index = Index;

        // I hate this
        id = ++lastUsedId;
    }

    public function tryActivate(beat:Int) {
        propagate(beat);
    }

    public function getTileType() {
        return 0;
    }

    private function onActivate(NoteLength:Int){
        var coords = tilemap.getTileCoordsByIndex(index);
        var position = tilemap.tilemap.getPosition(); 
        FlxG.state.add(new WaterSplash(position.x + (coords.x * MapController.TILE_WIDTH), position.y + (coords.y * MapController.TILE_HEIGHT), NoteLength));
    }

    private function propagate(beat:Int) {
        if (delayActivate) {
            delayActivate = false;
            return;
        }

        if (propagations.length <= 0)
            return;

        var neighbors = getNeighbors();
        var activate = false;
        var longestNoteLength = 1;

        for(pd in propagations) {
            if (pd.shouldPropagate(beat)) {
                longestNoteLength = Std.int(Math.max(longestNoteLength, cast(pd.noteLength, Int)));
                activate = true;
                // Ugh don't like this nested for
                for(neighbor in neighbors) {
                    if (!pd.contains(neighbor)) {
                        neighbor.setActivate(pd, neighbor.index >= index);
                    }
                }

                pd.checkFinished();
                propagations.remove(pd);
            }
        }

        if (activate)
            onActivate(longestNoteLength);
    }

    public function setActivate(Data:PropagateData, Delay:Bool) {
        Data.add(this);
        propagations.push(Data);
        delayActivate = Delay;
    }

    public function getNeighbors():Array<Tile> {
        var currentCoords = tilemap.getTileCoordsByIndex(index);
        var neighbors = new Array<Tile>();

        // up
        if (currentCoords.y - 1 >= 0) {
            var tile = tilemap.getTile(Std.int(currentCoords.x),
                Std.int(currentCoords.y)-1);
            
            neighbors.push(tile);
        }

        // down
        if (currentCoords.y + 1 < tilemap.height()) {
            var tile = tilemap.getTile(Std.int(currentCoords.x),
                Std.int(currentCoords.y)+1);
            
            neighbors.push(cast(tile, Tile));
        }

        // left
        if (currentCoords.x - 1 >= 0) {
            var tile = tilemap.getTile(Std.int(currentCoords.x)-1,
                Std.int(currentCoords.y));
            
            neighbors.push(tile);
        }

        //right
        if (currentCoords.x + 1 < tilemap.width()) {
            var tile = tilemap.getTile(Std.int(currentCoords.x)+1,
                Std.int(currentCoords.y));
            
            neighbors.push(tile);
        }

        return neighbors;
    }
}