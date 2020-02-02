package ui;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import GameOverState;

class DayTimer extends FlxBar {

    private var gameDuration:Int = 180;
    private var timer:FlxTimer;
    
    public function new():Void {

        super();
        new FlxTimer().start(gameDuration, eOver, 1);

        this.value = 100;
        FlxTween.tween(this, { value: 0 } , gameDuration);

        this.scrollFactor.set(0,0);
        this.x = 190;
        this.y = 170;
    }

    private function eOver(timer:FlxTimer) {
        FlxG.switchState(new GameOverState()); 
    }

}