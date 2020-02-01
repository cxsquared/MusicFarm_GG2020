package ui;

import flixel.FlxSprite;
import flixel.FlxG;

class FlowerPicker extends FlxSprite {

    private var flowers:Array<Int>;
    private var curIndex:Int = 0;

    public function new():Void {
        super();
        flowers = [1,2];
    }

    override public function update(elapsed:Float):Void
    {
        s_input();
        super.update(elapsed);
    }

    private function s_input():Void {
        var forward:Bool = false;
        var backward:Bool = false;
        forward = FlxG.keys.anyPressed([F]);
        backward = FlxG.keys.anyPressed([R]);

        //bounce anim because why not

        //move forward
        if(forward) {
            curIndex ++;
            if(curIndex >= flowers.length) curIndex = 0;
        } else if (backward) {
            curIndex --;
            if(curIndex < 0) curIndex = flowers.length - 1;
        }

        //bounce anim because why not
    }
}