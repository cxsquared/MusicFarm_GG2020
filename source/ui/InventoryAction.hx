package ui;

import flixel.FlxSprite;

typedef IAction = {
    var icon:String;
    var action:Void->Void;
    var aType:String;
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