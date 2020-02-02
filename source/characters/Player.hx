package characters;

import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxSignal;

class Player extends FlxSprite {

    private var walkSpeed:Int;
    private var spacebar:FlxSprite;
    private var e:FlxSprite;
    private var q:FlxSprite;
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
        
        spacebar = new FlxSprite();
        spacebar.loadGraphic("assets/images/spacebar.png");
        spacebar.scale.set(.8, .8);
        FlxG.state.add(spacebar);

        q = new FlxSprite();
        q.loadGraphic("assets/images/q.png");
        FlxG.state.add(q);

        e = new FlxSprite();
        e.loadGraphic("assets/images/e.png");
        FlxG.state.add(e);
    }

    override public function update(elapsed:Float):Void
    {
        movement();

        spacebar.x = this.x + this.width/2 - spacebar.width/2;
        spacebar.y = this.y + this.height + 2;

        q.x = this.x - q.width - 2;
        q.y = this.y + 2;

        e.x = this.x + this.width + 2;
        e.y = this.y + 2;

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