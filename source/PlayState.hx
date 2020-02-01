package;

import music.NoteManager;
import tiles.*;
import flixel.FlxState;
import flixel.FlxG;
import characters.Player;
import ui.FlowerPicker;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	public var map:MapController;

	private var player:Player;
	private var fp:FlowerPicker;

	private var noteManager = new NoteManager();

	private var background = new FlxSprite();

	override public function create():Void
	{
		super.create();

		background.loadGraphic("assets/images/background.png");
		background.setPosition(-32, -32);
		add(background);

		map = new MapController();

		FlxG.worldBounds.set(background.x, background.y, background.width, background.height);

		FlxG.camera.zoom = 2;
		add(map.tilemap);

		//Cluttering things up because that's how I am
		player = new Player();
		add(player);
		player.actionSignal.add(playerAction);

		FlxG.camera.follow(player);

		fp = new FlowerPicker();
		add(fp);
	}

	private function playerAction(action:String):Void {

		var x = Std.int(player.x / MapController.TILE_WIDTH);
		var y = Std.int(player.y / MapController.TILE_HEIGHT);

		doAction("note", x, y);
	}

	private function doAction(action:String,x:Int, y:Int) {
		var currTile = map.getTile(x, y);

		if(action == "activator") {
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

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		if (FlxG.mouse.justPressed) {
			var x = Std.int(FlxG.mouse.x / MapController.TILE_WIDTH);
			var y = Std.int(FlxG.mouse.y / MapController.TILE_HEIGHT);

			if (FlxG.keys.pressed.SHIFT) {
				doAction("activator",x,y);
			} else {
				doAction("note", x, y);
			}
			
		}
	}
}
