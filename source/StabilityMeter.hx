package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class StabilityMeter extends FlxTypedSpriteGroup<FlxSprite>
{
	private var arrow:FlxSprite;
	private var percentage:Float = 1.0;

	public function new()
	{
		super(FlxG.width / 2, FlxG.height - 70);
		scrollFactor.set(0, 0);
		add(new FlxSprite(0, 0, "assets/images/meter.png"));
		add(arrow = new FlxSprite(64, 55, "assets/images/arrow.png"));
		arrow.origin.set(0, 3.5);
		arrow.scrollFactor.set(0, 0);
		screenCenter(X);
	}

	private var tween:FlxTween;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (percentage < 0.35 && tween == null)
		{
			tween = FlxTween.angle(arrow, 0.0, -180.0, 1.0, {type: PINGPONG, ease: FlxEase.bounceInOut});
		}
		else if (tween == null)
		{
			arrow.angle = (1 - percentage) * -180.0;
		}
	}

	public function setPercentage(p:Float)
	{
		percentage = p;
	}
}
