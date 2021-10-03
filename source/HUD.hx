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
	private var debugText1:FlxText;

	@:access(PlayState)
	public function new(parent:PlayState)
	{
		super(0, 0);
		scrollFactor.set(0, 0);
		add(meter = new StabilityMeter());
		meter.scrollFactor.set(0, 0);
		this.parent = parent;
		add(debugText1 = new FlxText(20, 20, "Enemy angle = "));
	}

	@:access(PlayState)
	@:access(Badguy)
	override function update(elapsed:Float)
	{
		super.update(elapsed);
		meter.setPercentage(parent.getCurrentStability());
		debugText1.text = "Enemy angle = " + parent.kraken.angleAroundWorld + "";
	}
}
