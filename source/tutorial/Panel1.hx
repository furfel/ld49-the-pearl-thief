package tutorial;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class Panel1 extends BasicPanel
{
	public function new()
	{
		super();
		nextPanel = Panel2;
	}

	override function create()
	{
		super.create();
		var t:FlxText;
		add(t = new FlxText(32, 64, "World of alpacas is kept stable", 16));
		t.screenCenter(X);
		add(t = new FlxText(32, 88, "using magical pearls.", 16));
		t.screenCenter(X);
		createPlayerExample();
		createPearlExample();
	}

	private function createPlayerExample()
	{
		var s = new FlxSprite(128, FlxG.height - 128);
		s.loadGraphic("assets/images/player-tut.png", true, 64, 64);
		s.animation.add("_", [0, 1], 9);
		s.animation.play("_");
		add(s);
	}

	private function createPearlExample()
	{
		var s = new FlxSprite(FlxG.width - 64 - 128, FlxG.height - 128);
		s.loadGraphic("assets/images/pearl-tut.png", true, 16, 24);
		s.animation.add("_", [0, 1, 2, 3, 4, 5, 4, 3, 2, 1], 9);
		s.animation.play("_");
		add(s);
	}
}
