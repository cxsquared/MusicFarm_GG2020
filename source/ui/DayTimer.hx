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

        FlxTween.tween(this, {} , 180.0)
    }

    private function eOver(timer:FlxTimer) {

    }

}