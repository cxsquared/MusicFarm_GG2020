package music;

import flixel.FlxG;
import flixel.system.FlxSound;

class NoteManager {
    private static var instrumentSounds = new Map<InstrumentType, Array<FlxSound>>();

    public function new() {
        instrumentSounds[InstrumentType.Bell] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Organ] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.String] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Tuba] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Woodwind] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Piano] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Whistle] = new Array<FlxSound>();
        instrumentSounds[InstrumentType.Drum] = new Array<FlxSound>();

        for(i in 0...16) {
            // bell
            var s = new FlxSound();
            s.loadEmbedded('assets/sounds/bell$i.wav');
            instrumentSounds[InstrumentType.Bell].push(s);

            //organ
            s = new FlxSound();
            s.volume = .25;
            s.loadEmbedded('assets/sounds/organ$i.wav');
            instrumentSounds[InstrumentType.Organ].push(s);

            // string
            s = new FlxSound();
            s.volume = .25;
            s.loadEmbedded('assets/sounds/string$i.wav');
            instrumentSounds[InstrumentType.String].push(s);

            // tuba
            s = new FlxSound();
            s.loadEmbedded('assets/sounds/tuba$i.wav');
            instrumentSounds[InstrumentType.Tuba].push(s);

            // piano 
            s = new FlxSound();
            s.volume = .25;
            s.loadEmbedded('assets/sounds/piano$i.wav');
            instrumentSounds[InstrumentType.Piano].push(s);

            // woodwind 
            s = new FlxSound();
            s.loadEmbedded('assets/sounds/woodwind$i.wav');
            instrumentSounds[InstrumentType.Woodwind].push(s);

            // whistle 
            s = new FlxSound();
            s.volume = .25;
            s.loadEmbedded('assets/sounds/whistle$i.wav');
            instrumentSounds[InstrumentType.Whistle].push(s);

            // drum 
            s = new FlxSound();
            s.volume = .15;
            s.loadEmbedded('assets/sounds/drum$i.wav');
            instrumentSounds[InstrumentType.Drum].push(s);
        }
    }

    public static function getInstrumentSound(instrument:InstrumentType, pitch:Int):FlxSound {
        if (pitch < 0 || pitch > 15)
            return null;

        return instrumentSounds[instrument][pitch];
    }

    private static var noteLengthTypes = [Quarter, Half, DottedHalf, Whole]; 

    public static function getRandomNoteLengthType() {
        return noteLengthTypes[FlxG.random.int(0, noteLengthTypes.length-1)];
    }
}

enum abstract InstrumentType(Int) {
    var Bell = 2;
    var Tuba = 3;
    var Drum = 4;
    var Whistle = 5;
    var String = 6;
    var Organ = 7;
    var Woodwind = 8;
    var Piano = 9;
}

enum abstract NoteLengthType(Int) {
    var Quarter = 1;
	var Half;
    var DottedHalf;
    var Whole;
}