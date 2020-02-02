package tiles;

import music.NoteManager.InstrumentType;
import flixel.FlxG;
import flixel.system.FlxSound;
import music.NoteManager;

class NoteTile extends Tile {
    public var sound:FlxSound;

    public var instrument:InstrumentType;

    public function new(Tilemap:MapController, Index:Int, Instrument:InstrumentType = InstrumentType.Bell) {
        super(Tilemap, Index);

        instrument = Instrument;

        var coords = Tilemap.getTileCoordsByIndex(Index);

        sound = NoteManager.getInstrumentSound(instrument, Std.int(coords.y));
    }

    public override function getTileType() {
        return cast(instrument, Int);
    }

    public override function onActivate(NoteLength:Int) {
        super.onActivate(NoteLength);
        if (sound != null) {
            sound.play();
        } else {
            FlxG.log.error('can\'t play not for ${Std.int(tilemap.getTileCoordsByIndex(index).y)}');
        }
    }
}