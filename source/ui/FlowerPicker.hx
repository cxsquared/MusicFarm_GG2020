package ui;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import ui.InventoryAction;
import flixel.util.FlxSignal;

class FlowerPicker extends FlxGroup {

    private var flowers:Array<FlxSprite>;
    private var curIndex:Int = 0;
    private var tween:FlxTween;
    private var inventoryData:Array<IAction>;

    public var actionSignal:FlxTypedSignal<String->Void>;

    public function new():Void {
        super();

        actionSignal = new FlxTypedSignal<String->Void>();


        inventoryData = [
            { icon: "assets/images/temp_tiles.png", action: function() { trace("AAAA"); }, aType: "activator" },
            { icon: "assets/images/temp_tiles.png", action: function() { trace("AAAA"); }, aType: "flower" }
        ];

        flowers =  new Array<FlxSprite>();
  
        for (i in 0...inventoryData.length) {
            var nSprite = new FlxSprite();
            //fixed UI
            nSprite.scrollFactor.set(0,0);
            nSprite.x = 300 + (i * 30);
            nSprite.y = 250 ;
            add(nSprite);
            flowers.push(nSprite);
        }
    }

    override public function update(elapsed:Float):Void
    {
        s_input();
        super.update(elapsed);
    }

    private function s_input():Void {
        var forward:Bool = false;
        var backward:Bool = false;
        var _action:Bool = false;

        forward = FlxG.keys.anyJustPressed([F]);
        backward = FlxG.keys.anyJustPressed([R]);
        _action =  FlxG.keys.anyJustPressed([SPACE]);


        if(forward || backward) {

            //stop old animation just in case
            if(tween != null) tween.cancel();

            //bounce anim because why not
            FlxTween.tween(flowers[curIndex], { y: 250 }, .7, { ease: FlxEase.quadOut});

            //move forward
            if(forward) {
                curIndex ++;
                if(curIndex >= flowers.length) curIndex = 0;
            } else if (backward) {
                curIndex --;
                if(curIndex < 0) curIndex = flowers.length - 1;
            }

            //bounce anim because why not
            tween = FlxTween.tween(flowers[curIndex], { y: 270 }, .7, { ease: FlxEase.quadOut});
        }


        if(_action) {
            actionSignal.dispatch(inventoryData[curIndex].aType);
        }
    }
}