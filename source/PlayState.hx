package;

import flixel.FlxState;
import flixel.FlxG;
import tiles.FlowerMapData;

class PlayState extends FlxState
{
	public var map:FlowerMapData;

	override public function create():Void
	{
		super.create();

		FlxG.camera.zoom = 2;

		map = new FlowerMapData();

		map.tilemap.setPosition(FlxG.width/2-map.tilemap.width/2, FlxG.height/2-map.tilemap.height/2);

		add(map.tilemap);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
	}
}
