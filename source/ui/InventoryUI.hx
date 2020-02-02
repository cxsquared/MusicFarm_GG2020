package ui;

import flixel.group.FlxGroup;
import ui.FlowerPicker;

class InventoryUI extends FlxGroup {

    private var flowerPicker:FlowerPicker;

    public function new():Void {
        super();

        flowerPicker = new FlowerPicker();
        add(flowerPicker);
    }
    
}