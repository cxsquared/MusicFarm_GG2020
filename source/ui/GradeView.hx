package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;

class GradeView extends FlxSpriteGroup {

    public function new():Void {
        super();
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