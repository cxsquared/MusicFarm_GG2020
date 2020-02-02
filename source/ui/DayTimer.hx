package ui;

import flixel.FlxSprite;
import flixel.util.FlxTimer;
import flixel.ui.FlxBar;
import flixel.tweens.FlxTween;
import flixel.FlxG;
import flixel.util.FlxSignal;
import GameOverState;

class DayTimer extends FlxBar {

    private var gameDuration:Int = 60;
    private var timer:FlxTimer;
    private var stage = 0;
    
    public var dayStage:FlxTypedSignal<Int->Void>;

    
    public function new():Void {

        super();
        new FlxTimer().start(gameDuration, eOver, 1);

        this.value = 100;
        FlxTween.tween(this, { value: 0 } , gameDuration);

        dayStage = new FlxTypedSignal<Int->Void>();

        this.scrollFactor.set(0,0);
        this.x = 190;
        this.y = 170;
    }

    override public function update(elapsed:Float):Void
    {

        if(this.value < 75 && this.stage == 0) {
            dayStage.dispatch(stage);
            stage = 1;
        }

        if(this.value < 50 && this.stage == 1) {
            dayStage.dispatch(stage);
            stage = 2;
        }

        if(this.value < 25 && this.stage == 2) {
            dayStage.dispatch(stage);
            stage = 3;
        }

        super.update(elapsed);
    }

    private function eOver(timer:FlxTimer) {
        //FlxG.switchState(new GameOverState()); 
    }

}