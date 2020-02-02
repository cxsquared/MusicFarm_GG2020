package ui;

import flixel.graphics.frames.FlxFrame;
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

    public var unlockMax = 2;

    public var actionSignal:FlxTypedSignal<String->InstrumentType->Void>;

    public function new():Void {
        super();

        actionSignal = new FlxTypedSignal<String->InstrumentType->Void>();


        inventoryData = [
            { icon: "assets/images/icons/activatoricon.png", instrument: InstrumentType.Bell, aType: "activator" },
            { icon: "assets/images/icons/bellicon.png", instrument: InstrumentType.Bell, aType: "flower" },
            { icon: "assets/images/icons/tubaicon.png", instrument: InstrumentType.Tuba, aType: "flower" },
            { icon: "assets/images/icons/drumicon.png", instrument: InstrumentType.Drum, aType: "flower" },
            { icon: "assets/images/icons/whistleicon.png", instrument: InstrumentType.Whistle, aType: "flower" },
            { icon: "assets/images/icons/stringicon.png", instrument: InstrumentType.String, aType: "flower" },
            { icon: "assets/images/icons/organicon.png", instrument: InstrumentType.Organ, aType: "flower" },
            { icon: "assets/images/icons/woodwindicon.png", instrument: InstrumentType.Woodwind, aType: "flower" },
            { icon: "assets/images/icons/pianoicon.png", instrument: InstrumentType.Piano, aType: "flower" }
        ];

        flowers =  new Array<FlxSprite>();
  
        for (i in 0...inventoryData.length) {
            var nSprite = new FlxSprite();
            //fixed UI
            nSprite.scrollFactor.set(0,0);

            nSprite.loadGraphic(inventoryData[i].icon, true, 16, 16);
            nSprite.x = 200 + (i * 25);
            nSprite.y = 450;
            add(nSprite);
            flowers.push(nSprite);
        }

        unlockStage(1);
    }

    public function unlockStage(stage:Int) {
        unlockMax = Math.floor( (stage * .33) * flowers.length);

        for(i in 0 ... flowers.length) {
            
            if(i <= unlockMax) flowers[i].alpha = 1;
            else flowers[i].alpha = .3;
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
                if(curIndex >= unlockMax) curIndex = 0;
            } else if (backward) {
                curIndex --;
                if(curIndex < 0) curIndex = unlockMax;
            }

            //bounce anim because why not
            tween = FlxTween.tween(flowers[curIndex], { y: 430 }, .7, { ease: FlxEase.quadOut});
        }


        if(_action) {
            actionSignal.dispatch(inventoryData[curIndex].aType, inventoryData[curIndex].instrument);
        }
    }
}