package tutorial;

import flixel.FlxG;
import flixel.FlxSprite;
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
		add(t = new FlxText(32, 64, "Protect stability of this land as long", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 80, "as you can. The more unstable is the space-time", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 96, "continuum, the harder it becomes to play.", 12));
		t.screenCenter(X);
		var s:FlxSprite;
		add(s = new FlxSprite(0, FlxG.height - 192, "assets/images/meter-tut2.png"));
		s.screenCenter(X);
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
