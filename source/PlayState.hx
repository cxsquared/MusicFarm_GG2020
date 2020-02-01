package;

import flixel.FlxState;
import flixel.FlxG;
import tiles.FlowerMapData;
import characters.Player;
import ui.FlowerPicker;

class PlayState extends FlxState
{
	public var map:FlowerMapData;

	private var player:Player;
	private var fp:FlowerPicker;

	override public function create():Void
	{
		super.create();

		FlxG.camera.zoom = 2;

		map = new FlowerMapData();

		map.tilemap.setPosition(FlxG.width/2-map.tilemap.width/2, FlxG.height/2-map.tilemap.height/2);

		add(map.tilemap);
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
