package tiles;

import flixel.FlxG;
import flixel.system.FlxSound;
import music.*;

class NoteTile extends Tile {
    public var sound:FlxSound;

    public var instrument = InstrumentType.Bell;

    public function new(Tilemap:MapController, Index:Int) {
        super(Tilemap, Index);

        tileType = 2;
        var coords = Tilemap.getTileCoordsByIndex(Index);

        sound = NoteManager.getInstrumentSound(instrument, Std.int(coords.y));
    }

    public override function onActivate() {
        super.onActivate();
        if (sound != null) {
            sound.play();
        } else {
            FlxG.log.error('can\'t play not for ${Std.int(tilemap.getTileCoordsByIndex(index).y)}');
        }
        FlxG.log.add("Activating note");
    }
}