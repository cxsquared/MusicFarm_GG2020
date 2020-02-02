package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxSignal;

class GradeView extends FlxSpriteGroup {

    public var gradeIssued:FlxTypedSignal<Int->Void>;

    public function new():Void {
        super();

        gradeIssued = new FlxTypedSignal<Int->Void>();

        this.x = 100;

        for(i in 0 ... 5) {
            var newStar = new FlxSprite();
            newStar.loadGraphic("assets/images/star.png");
            newStar.x = i * 30;
            add(newStar);
        }

        showStars(0);
    }

    public function renderJudgement(judgement:Int) {
        showStars(judgement+1);
        FlxTween.tween(this, { alpha: 1 }, .4 );

        gradeIssued.dispatch(judgement+1);
    }

    public function showStars(starAmt:Int) {

        this.forEach(function (sp:FlxSprite) {
            sp.visible = false;
        });

        for(i in 0 ... starAmt) {
            this.members[i].visible = true;
        }
    }

}