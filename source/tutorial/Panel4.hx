package tutorial;

import flixel.FlxG;
import flixel.text.FlxText;
import js.html.TextTrackCueList;

class Panel4 extends BasicPanel
{
	public function new()
	{
		super();
		nextPanel = null;
	}

	override function create()
	{
		super.create();
		var t:FlxText;
		add(t = new FlxText(32, 32, "Protect stability of this land as long", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 48, "as you can. The less stable space-time", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 64, "continuum, the harder it becomes.", 12));
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (!switching && FlxG.keys.justPressed.ANY)
		{
			switching = true;
			camera.fade(0.3, () -> FlxG.switchState(new PlayState()));
		}
	}
}
