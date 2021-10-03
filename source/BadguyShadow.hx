package;

import flixel.FlxSprite;

class BadguyShadow extends FlxSprite
{
	public function new()
	{
		super();
		loadGraphic("assets/images/krakenshadow.png");
		alpha = 0;
	}
}
