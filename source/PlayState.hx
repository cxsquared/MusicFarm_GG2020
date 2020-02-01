package;

import flixel.FlxState;
import characters.Player;
import ui.FlowerPicker;

class PlayState extends FlxState
{

	private var player:Player;
	private var fp:FlowerPicker;

	override public function create():Void
	{
		super.create();

		//Cluttering things up because that's how I am
		player = new Player();
		add(player);

		fp = new FlowerPicker();
		add(fp);

	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
