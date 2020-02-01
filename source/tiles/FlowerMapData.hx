package tiles;

import flixel.FlxG;
import flixel.math.FlxPoint;
import flixel.tile.FlxTilemap;
import flixel.util.FlxTimer;

class FlowerMapData {
    public var tilemap:FlxTilemap;
    private var tileData = new Array<Tile>();

    public static var bpm:Float = 100;

    private var timer = new FlxTimer();

    public function new() {
        tilemap = new FlowerMap();

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

    private var pulseCount = 0;

    public function pulse(t:FlxTimer) {
        FlxG.watch.addQuick("pulse", pulseCount++);

        for(i in 0...length()-1) {
            tileData[i].tryActivate();
        }

        timer.start(getDelay(), pulse);
    }

    public static function getDelay():Float {
        return (60000/bpm)/1000;
    }

    public function getTile(X:Int, Y:Int):Tile {
        return tileData[X + (Y * width())];
    }
    
    public function getTileCoordsByIndex(Index:Int):FlxPoint {
        var x = Index % tilemap.widthInTiles;
        var y = Index/tilemap.widthInTiles;


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

}