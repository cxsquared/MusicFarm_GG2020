package ui;

import flixel.FlxSprite;

class StandardFlower extends FlxSprite {

    public function new() {
        super();
        loadGraphic("assets/images/temp_tiles.png", true, 16, 16);
        animation.frameIndex = 1;
    }

    public function useAction() {

    }
}