package characters;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSignal;

class Player extends FlxSprite {

    private var walkSpeed:Int;
    public var actionSignal:FlxTypedSignal<String->Void>;

    public function new() {
        super();
        walkSpeed = 50;

        this.drag.x = 130;
        this.drag.y = 130;

        actionSignal = new FlxTypedSignal<String->Void>();

        loadGraphic("assets/images/gwensprite.png", true, 15, 26);
		animation.add("Default", [3], 5);
		animation.add("Up", [0, 1], 5);
		animation.add("Down", [2, 3], 5);
		animation.add("Right", [4, 5], 5);
		animation.add("Left", [6, 7], 5);
    }

    override public function update(elapsed:Float):Void
    {
        movement();
        super.update(elapsed);
    }

    function movement():Void {

        var _up:Bool = false;
        var _down:Bool = false;
        var _left:Bool = false;
        var _right:Bool = false;
        var _action:Bool = false;

        _up = FlxG.keys.anyPressed([UP, W]);
        _down = FlxG.keys.anyPressed([DOWN, S]);
        _left = FlxG.keys.anyPressed([LEFT, A]);
        _right = FlxG.keys.anyPressed([RIGHT, D]);
       // _action =  FlxG.keys.anyJustPressed([SPACE]);

        if (_up) {
			animation.play("Up");
			this.facing = FlxObject.UP;
			velocity.y = -walkSpeed;
		} else if (_left) {
			animation.play("Left");
			this.facing = FlxObject.LEFT;
			velocity.x = -walkSpeed;
		} else if (_down) {
			animation.play("Down");
			this.facing = FlxObject.DOWN;
			velocity.y = walkSpeed;
		} else if (_right) {
			animation.play("Right");
			this.facing = FlxObject.RIGHT;
			velocity.x = walkSpeed;
		} else {
            animation.pause();
			//this.frame = this.frame;
        }
        
        if(_action) {
            actionSignal.dispatch("plant");
        }
    }
}