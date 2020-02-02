import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import StoryState;

class TitleState extends FlxState {
    
    override public function create() {
        super.create();

        var titleGraphic = new FlxSprite();
        titleGraphic.loadGraphic("assets/images/musicFarmTitle.png");
        add(titleGraphic);
    }

    override public function update(delta:Float) {
        super.update(delta);

        if (FlxG.mouse.justPressed || FlxG.keys.justPressed.SPACE) {
            FlxG.switchState(new StoryState()); 
        }
    }

}