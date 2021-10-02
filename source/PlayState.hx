package;

import flixel.FlxG;
import flixel.FlxState;
import pearl.Pearl;

class PlayState extends FlxState
{
	override public function create()
	{
		super.create();
		FlxG.camera.antialiasing = true;
		add(new Pearl(100, 100, 0xFFAAEE22));
		add(new Pearl(200, 180, 0xFFFF2222));
		add(new Pearl(180, 70, 0xFF99EEFF));
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
