package;

import tiles.*;
import flixel.FlxState;
import flixel.FlxG;
import characters.Player;
import ui.FlowerPicker;

class PlayState extends FlxState
{
	public var map:MapController;

	private var player:Player;
	private var fp:FlowerPicker;

	override public function create():Void
	{
		super.create();

		map = new MapController();

		FlxG.worldBounds.set(map.tilemap.x, map.tilemap.y, map.tilemap.width, map.tilemap.height);

		FlxG.camera.zoom = 2;
		FlxG.camera.follow(map.tilemap);

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

		if (FlxG.mouse.justPressed) {
			var x = Std.int(FlxG.mouse.x / MapController.TILE_WIDTH);
			var y = Std.int(FlxG.mouse.y / MapController.TILE_HEIGHT);

			var currTile = map.getTile(x, y);

			if (FlxG.keys.pressed.SHIFT) {
				if (!Std.is(currTile, ActivatorTile)) {
					map.setTile(x, y, new ActivatorTile(map, map.coordsToIndex(x, y)));
				} else {
					map.setTile(x, y, new Tile(map, map.coordsToIndex(x, y)));
				}
			} else {
				if (!Std.is(currTile, NoteTile)) {
					map.setTile(x, y, new NoteTile(map, map.coordsToIndex(x, y)));
				} else {
					map.setTile(x, y, new Tile(map, map.coordsToIndex(x, y)));
				}
			}
		}
	}
}
