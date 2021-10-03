package;

import flixel.FlxGame;
import openfl.display.Sprite;
import tutorial.Panel1;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(640, 480, Panel1, true));
	}
}
