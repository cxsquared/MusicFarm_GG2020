package;

import ui.GradeView;
import music.NoteManager;
import tiles.*;
import flixel.FlxState;
import flixel.FlxG;
import characters.Player;
import flixel.group.FlxGroup;
import ui.FlowerPicker;
import ui.DayTimer;
import flixel.FlxSprite;

class PlayState extends FlxState
{
	public var map:MapController;

	private var UIGroup:FlxGroup;
	private var player:Player;
	private var fp:FlowerPicker;

	private var noteManager = new NoteManager();

	private var background = new FlxSprite();

	override public function create():Void
	{
		super.create();

		/////////Map stuff//////
		background.loadGraphic("assets/images/background.png");
		background.setPosition(-32, -32);
		add(background);

		map = new MapController();

		FlxG.worldBounds.set(background.x, background.y, background.width, background.height);

		FlxG.camera.zoom = 2;
		FlxG.camera.setScrollBounds(-32, 288, -32, 288);
		add(map.tilemap);

		//Cluttering things up because that's how I am
		player = new Player();
		add(player);

		//FlxG.camera.follow(player);


		////////////UI STuff/////////////
		fp = new FlowerPicker();
		add(fp);
		fp.actionSignal.add(playerAction);

		UIGroup = new FlxGroup();
		add(UIGroup);
		
		//Countless countdowns
		var dt = new DayTimer();
		UIGroup.add(dt);

		var gv = new GradeView();
		UIGroup.add(gv);
		
		//unlocks / events based on grading and jugement
		dt.dayStage.add(gv.renderJudgement);
		gv.gradeIssued.add(fp.unlockStage);
	}

	private function playerAction(action:String, instrument:InstrumentType):Void {

		var x = Std.int(player.x / MapController.TILE_WIDTH);
		var y = Std.int(player.y / MapController.TILE_HEIGHT);

		doAction(x, y, action, instrument);
	}

	private function doAction(x:Int, y:Int, action:String, instrument:InstrumentType = InstrumentType.Bell) {
		var currTile = map.getTile(x, y);

		if(action == "activator") {
			if (!Std.is(currTile, ActivatorTile)) {
				map.setTile(x, y, new ActivatorTile(map, map.coordsToIndex(x, y)));
			} else {
				map.setTile(x, y, new Tile(map, map.coordsToIndex(x, y)));
			}
		} else {
			if (!Std.is(currTile, NoteTile)) {
				map.setTile(x, y, new NoteTile(map, map.coordsToIndex(x, y), instrument));
			} else {
				map.setTile(x, y, new Tile(map, map.coordsToIndex(x, y)));
			}
		}
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);

		/*
		if (FlxG.mouse.justPressed) {
			var x = Std.int(FlxG.mouse.x / MapController.TILE_WIDTH);
			var y = Std.int(FlxG.mouse.y / MapController.TILE_HEIGHT);

			if (FlxG.keys.pressed.SHIFT) {
				doAction("activator",x,y);
			} else {
				doAction("note", x, y);
			}
			
		}
		*/
	}
}
