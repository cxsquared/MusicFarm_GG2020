package ui;

import flixel.FlxSprite;
import music.NoteManager;

typedef IAction = {
    var icon:String;
    var aType:String;
    var instrument:InstrumentType;
}

class InventoryAction {

    public var actionIcon:FlxSprite;

    public function new(spriteUrl:String) {
        actionIcon = new FlxSprite();
        actionIcon.loadGraphic(spriteUrl);
    }

    public function action() {

    }
}