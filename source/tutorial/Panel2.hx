package tutorial;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;

class Panel2 extends BasicPanel
{
	public function new()
	{
		super();
		nextPanel = Panel3;
	}

	override function create()
	{
		super.create();
		var t:FlxText;
		add(t = new FlxText(32, 64, "However, evil Kraken wants to", 16));
		t.screenCenter(X);
		add(t = new FlxText(32, 88, "steal all the pearls.", 16));
		t.screenCenter(X);
		createPearlExample();
		createKrakenExample();
	}

	private function createKrakenExample()
	{
		var s = new FlxSprite(FlxG.width - 64 - 128, FlxG.height - 192);
		s.loadGraphic("assets/images/kraken-tut.png", true, 64, 64);
		s.animation.add("_", [0, 1, 2, 1], 9);
		s.animation.play("_");
		add(s);
		s.screenCenter(X);
	}

	private function createPearlExample()
	{
		var s = new FlxSprite(FlxG.width - 64 - 128, FlxG.height - 128);
		s.loadGraphic("assets/images/pearl-tut.png", true, 16, 24);
		s.animation.add("_", [0, 1, 2, 3, 4, 5, 4, 3, 2, 1], 9);
		s.animation.play("_");
		add(s);
		s.screenCenter(X);
	}
}
