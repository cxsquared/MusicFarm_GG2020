package ui;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.tweens.FlxTween;

class DayTimer extends FlxBar {

    private var timer:FlxTimer;

    public function new():Void {
        super();
        new FlxTimer().start(180.0, eOver, 1);

        this.value = 100;
        FlxTween.tween(this, { value: 0 } , 180.0);

        this.scrollFactor.set(0,0);
        this.x = 400;
        this.y = 400;
    }

    private function eOver(timer:FlxTimer) {

    }

}