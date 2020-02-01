package tiles;

import flixel.FlxG;

class Tile {
    static var lastUsedId = 0;

    public var id:Int;
    public var shouldActivate:Bool = false;
    public var delayActivate:Bool = false;

    public var propagations = new Array<PropagateData>();
    public var tilemap:FlowerMapData;
    public var index:Int;

    public function new(Tilemap:FlowerMapData, Index:Int) {
        tilemap = Tilemap;
        index = Index;

        // I hate this
        id = ++lastUsedId;
    }

    public function tryActivate() {
        propagate();
    }

    private function onActivate(){
        var coords = tilemap.getTileCoordsByIndex(index);
        var position = tilemap.tilemap.getPosition(); 
        FlxG.state.add(new WaterSplash(position.x + coords.x * 16, position.y + coords.y * 16));
    }

    private function propagate() {
        if (delayActivate) {
            delayActivate = false;
            return;
        }

        if (!shouldActivate)
            return;

        shouldActivate = false;

        onActivate();

        var neighbors = getNeighbors();

        while(propagations.length > 0) {
            var pd = propagations.pop();
            // Ugh don't like this nested for
            for(neighbor in neighbors) {
                if (!pd.contains(neighbor)) {
                    neighbor.setActivate(pd, neighbor.id > id);
                }
            }

            pd.checkFinished();
        }
    }

    public function setActivate(Data:PropagateData, Delay:Bool) {
        Data.add(this);
        propagations.push(Data);
        delayActivate = Delay;
        shouldActivate = true;
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