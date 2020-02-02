package ui;

import flixel.group.FlxGroup;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import ui.InventoryAction;
import flixel.util.FlxSignal;
import music.NoteManager;

class FlowerPicker extends FlxGroup {

    private var flowers:Array<FlxSprite>;
    private var curIndex:Int = 0;
    private var tween:FlxTween;
    private var inventoryData:Array<IAction>;

    public var actionSignal:FlxTypedSignal<String->InstrumentType->Void>;

    public function new():Void {
        super();

        actionSignal = new FlxTypedSignal<String->InstrumentType->Void>();


        inventoryData = [
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Bell, aType: "activator" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Bell, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Tuba, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Drum, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Whistle, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.String, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Organ, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Woodwind, aType: "flower" },
            { icon: "assets/images/temp_tiles.png", instrument: InstrumentType.Piano, aType: "flower" }
        ];

        flowers =  new Array<FlxSprite>();
  
        for (i in 0...inventoryData.length) {
            var nSprite = new FlxSprite();
            //fixed UI
            nSprite.scrollFactor.set(0,0);
            nSprite.x = 200 + (i * 25);
            nSprite.y = 450;
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
            //if(tween != null) tween.cancel();

            //bounce anim because why not
            FlxTween.tween(flowers[curIndex], { y: 450 }, .7, { ease: FlxEase.quadOut});

            //move forward
            if(forward) {
                curIndex ++;
                if(curIndex >= flowers.length) curIndex = 0;
            } else if (backward) {
                curIndex --;
                if(curIndex < 0) curIndex = flowers.length - 1;
            }

            //bounce anim because why not
            tween = FlxTween.tween(flowers[curIndex], { y: 430 }, .7, { ease: FlxEase.quadOut});
        }


        if(_action) {
            actionSignal.dispatch(inventoryData[curIndex].aType, inventoryData[curIndex].instrument);
        }
    }
}