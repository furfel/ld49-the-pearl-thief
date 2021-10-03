package;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxPieDial;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class HUD extends FlxTypedSpriteGroup<FlxSprite>
{
	private var meter:StabilityMeter;
	private var parent:PlayState;
	private var timer:Timer;
	private var hits:FlxText;

	@:access(PlayState)
	public function new(parent:PlayState)
	{
		super(0, 0);
		scrollFactor.set(0, 0);
		add(meter = new StabilityMeter());
		meter.scrollFactor.set(0, 0);
		this.parent = parent;
		add(timer = new Timer(32, FlxG.height - 48, 24));
		add(hits = new FlxText(FlxG.width - 300, FlxG.height - 48, "Hits: 000", 24));
		hits.setBorderStyle(OUTLINE, FlxColor.BLACK, 2);
		hits.x = FlxG.width - hits.width - 32;
	}

	private var elapsedEpoch = 0.0;

	@:access(PlayState)
	@:access(Badguy)
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		meter.setPercentage(parent.getCurrentStability());
		elapsedEpoch += elapsed;
		timer.setTime(elapsedEpoch);
		if (parent.kraken.hits < 10)
			hits.text = "Hits: 00" + parent.kraken.hits;
		else if (parent.kraken.hits < 100)
			hits.text = "Hits: 0" + parent.kraken.hits;
		else
			hits.text = "Hits: " + parent.kraken.hits;
	}
}
