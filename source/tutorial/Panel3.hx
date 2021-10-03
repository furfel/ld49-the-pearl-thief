package tutorial;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class Panel3 extends BasicPanel
{
	public function new()
	{
		super();
		nextPanel = Panel4;
	}

	override function create()
	{
		super.create();
		var t:FlxText;
		add(t = new FlxText(32, 32, "Kraken is afraid of alpacas' spit.", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 48, "You can do it using spacebar.", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 64, "It's only low enough to be hit", 12));
		t.screenCenter(X);
		add(t = new FlxText(32, 72, "When reaching for the pearl.", 12));
		createSpitExample();
		add(new FlxSprite(48, FlxG.height - 128, "assets/images/player-tut2.png"));
	}

	private function createSpitExample()
	{
		var s = new FlxSprite(FlxG.width - 64 - 48, FlxG.height - 128);
		s.loadGraphic("assets/images/bullet-tut.png", true, 64, 64);
		s.animation.add("_", [0, 1], 9);
		s.animation.play("_");
		add(s);
		s.screenCenter(X);
	}
}
