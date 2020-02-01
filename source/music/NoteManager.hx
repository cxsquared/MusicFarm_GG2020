package music;

import flixel.system.FlxSound;

class NoteManager {
    private static var instrumentSounds = new Map<InstrumentType, Array<FlxSound>>();

    public function new() {
        instrumentSounds[InstrumentType.Bell] = new Array<FlxSound>();

        for(i in 0...16) {
            // bell
            var s = new FlxSound();
            s.loadEmbedded('assets/sounds/bell$i.wav');
            instrumentSounds[InstrumentType.Bell].push(s);
        }
    }

    public static function getInstrumentSound(instrument:InstrumentType, pitch:Int):FlxSound {
        if (pitch < 0 || pitch > 15)
            return null;

        return instrumentSounds[instrument][pitch];
    }

    public static function getNoteLength(type:NoteLengthType):Int {
        return cast(type, Int); 
    }
}

enum InstrumentType {
    Bell;
    Tuba;
}

enum NoteLengthType {
    Quarter;
    Half;
    DottedHalf;
    Whole;
}