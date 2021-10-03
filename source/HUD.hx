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

	@:access(PlayState)
	public function new(parent:PlayState)
	{
		super(0, 0);
		scrollFactor.set(0, 0);
		add(meter = new StabilityMeter());
		meter.scrollFactor.set(0, 0);
		this.parent = parent;
		add(timer = new Timer(32, FlxG.height - 32, 24));
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
	}
}
