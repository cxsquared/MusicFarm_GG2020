package tiles;

import flixel.FlxG;

class NoteTile extends Tile {
    public function new(Tilemap:FlowerMapData, Index:Int) {
        super(Tilemap, Index);
    }

    public override function onActivate() {
        super.onActivate();
        FlxG.log.add("Activating note");
    }
}