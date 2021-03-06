import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxTimer;

class StoryState extends FlxState {
    var bg = new FlxSprite();
    var fg = new FlxSprite();
    var cx = new FlxText();
    var travis = new FlxText();

    var bgs = ["assets/images/story_bg1.png",
                "assets/images/story_bg2.png",
                "assets/images/story_bg3.png",
                "assets/images/story_bg4.png"];

    var fgs = ["assets/images/story_fg1.png",
                "assets/images/story_fg2.png",
                "assets/images/story_fg3.png",
                "assets/images/story_fg4.png",
                "assets/images/story_fg5.png",
                "assets/images/story_fg6.png"];

    var currentFg = 0;
    var currentBg = 0;

    var bgTimer = new FlxTimer();
    var fgTimer = new FlxTimer();

    override public function create() {
        super.create();

        bg.loadGraphic(bgs[3]);
        bg.scale.set(2, 2);
        bg.screenCenter();
        add(bg);

        bgTimer.start(FlxG.random.float(0.01, .25), switchBackground);

        fg.loadGraphic(fgs[currentFg++]);
        fg.scale.set(2, 2);
        fg.screenCenter();
        add(fg);

        fgTimer.start(FlxG.random.float(2,4), switchForeground);

        cx = new FlxText();
        cx.text = "@cxsquared";
        cx.color = FlxColor.WHITE;
        cx.size = 28;
        cx.x = 8;
        cx.y = FlxG.height - cx.height - 8;
        add(cx);

        travis = new FlxText();
        travis.text = "@meanderingleaf";
        travis.color = FlxColor.WHITE;
        travis.size = 28;
        travis.x = FlxG.width - travis.width - 8;
        travis.y = FlxG.height - travis.height - 8;
        add(travis);

    }

    override public function update(delta:Float) {
        super.update(delta);

        if (FlxG.mouse.justPressed || FlxG.keys.justPressed.SPACE) {
            switchForeground();
        }
    }

    private function switchBackground(t:FlxTimer) {
        bg.loadGraphic(bgs[currentBg++ % bgs.length]);

        bgTimer.start(FlxG.random.float(0.01, .25), switchBackground);
    }

    private function switchForeground(t:FlxTimer=null) {
        if (currentFg < fgs.length) {
            fg.loadGraphic(fgs[currentFg++]);
        } else {
           FlxG.switchState(new PlayState()); 
        }

        fgTimer.reset();
        fgTimer.start(FlxG.random.float(2,4), switchForeground);
    }
}