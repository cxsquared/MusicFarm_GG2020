package tiles;

import flixel.FlxG;

class NoteTile extends Tile {
    public function new(Tilemap:MapController, Index:Int) {
        super(Tilemap, Index);

        tileType = 2;
    }

    public override function onActivate() {
        super.onActivate();
        FlxG.log.add("Activating note");
    }
}