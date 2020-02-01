import flixel.FlxG;
import tiles.*;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;

class MapController {
    public static inline var TILE_WIDTH = 16;
    public static inline var TILE_HEIGHT = 16;

    static var MAP = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,
                      0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,1,0,0,0,0,0,0,0,2,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
                      0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];


    public var tilemap:FlxTilemap;
    private var tileData = new Array<Tile>();

    public static var bpm:Float = 100;

    private var timer = new FlxTimer();

    public function new() {
        tilemap = new FlxTilemap();
        tilemap.loadMapFromArray(MAP, TILE_WIDTH, TILE_HEIGHT, AssetPaths.temp_tiles__png, TILE_WIDTH, TILE_HEIGHT);

        var currIdx = 0;
        for(td in tilemap.getData()) {
            if (td == 1) {
                tileData.push(new ActivatorTile(this, currIdx++));
            } else if (td == 2) {
                tileData.push(new NoteTile(this, currIdx++));
            } else {
                tileData.push(new Tile(this, currIdx++));
            }
        }

        timer.start(getDelay(), pulse);
    } 

    private var beat = 1;

    public function pulse(t:FlxTimer) {
        var hasActivators = false;
        for(tile in tileData) {
            if (Std.is(tile, ActivatorTile))
                hasActivators = true;

            tile.tryActivate(beat);
        }

        if (hasActivators)  {
            for(i in tilemap.getTileInstances(1)) {
                if (Std.is(tileData[i], ActivatorTile)) {
                    cast(tileData[i], ActivatorTile).tryStart(beat);
                }
            }
        }

        beat++;
        timer.start(getDelay(), pulse);
    }

    public static function getDelay():Float {
        return (60000/bpm)/1000;
    }

    public function setTile(X:Int, Y:Int, Tile:Tile) {
        if (!inRange(X, Y))
            return;

        tilemap.setTile(X, Y, Tile.tileType);
        tileData[coordsToIndex(X, Y)] = Tile;
    }

    private function inRange(X:Int, Y:Int):Bool {
        return coordsToIndex(X, Y) < tilemap.totalTiles;
    }

    public function getTile(X:Int, Y:Int):Tile {
        return tileData[coordsToIndex(X, Y)];
    }
    
    public function getTileCoordsByIndex(Index:Int):FlxPoint {
        var x = Index % width();
        var y = Index / width();


        return FlxPoint.weak(x, y);
    }

    public function height():Int {
        return tilemap.heightInTiles;
    }

    public function width():Int {
        return tilemap.widthInTiles;
    }

    public function length():Int {
        return tileData.length;
    }

    public function coordsToIndex(X:Int, Y:Int):Int {
        return X + (Y * width());
    }

}