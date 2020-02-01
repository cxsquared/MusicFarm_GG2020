package tiles;

import flixel.util.FlxTimer;
import flixel.FlxSprite;

class WaterSplash extends FlxSprite {

    public var lifeTimer = new FlxTimer();

    public function new(X:Float, Y:Float) {
        super(X, Y, "assets/images/water_temp.png");

        lifeTimer.start(FlowerMapData.getDelay(), onTimer);
    }

    private function onTimer(t:FlxTimer) {
        this.destroy();
    }
}

