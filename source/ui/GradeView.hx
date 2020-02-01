package ui;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

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
    }

    public function showStars(starAmt:Int) {

        this.forEach(function (sp:FlxSprite) {
            sp.visible = false;
        });

        for(i in 0 ... 5) {
            this.members[i].visible = true;
        }
    }

}