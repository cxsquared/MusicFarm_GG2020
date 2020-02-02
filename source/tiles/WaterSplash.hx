package tiles;

import flixel.util.FlxTimer;
import flixel.FlxSprite;

class WaterSplash extends FlxSprite {

    public var lifeTimer = new FlxTimer();

    public function new(X:Float, Y:Float, NoteLength:Int) {
        super(X, Y, "assets/images/water_temp.png");

        this.alpha = .7;

        lifeTimer.start(MapController.getDelay()*NoteLength, onTimer);
    }

    private function onTimer(t:FlxTimer) {
        this.destroy();
    }
}

