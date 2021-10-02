package pearl;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Pearl extends FlxTypedSpriteGroup<FlxSprite>
{
	public static final L = 0.8;
	public static final MAX_S = 0.9;

	private var pearl:FlxSprite;
	private var pearlStand:FlxSprite;
	private var hue:Float = 0;
	private var sat:Float = MAX_S;

	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		add(pearlStand = new FlxSprite(0, 0, "assets/images/pearlstand.png"));
		add(pearl = new FlxSprite(0, 0, "assets/images/pearl.png"));
		hue = FlxG.random.float(0, 360);
		pearl.color = FlxColor.fromHSL(hue, MAX_S, L);
		pearl.x = pearlStand.x + pearlStand.width / 2 - pearl.width / 2;
		pearl.y = pearlStand.y - pearl.height;
		pearlStand.solid = pearlStand.immovable = true;
		pearl.solid = true;
		animate();
	}

	private var tween:FlxTween;

	private function animate()
	{
		tween = FlxTween.linearMotion(pearl, pearl.x, pearl.y + 1, pearl.x, pearl.y - 3, 0.4, true, {ease: FlxEase.cubeInOut, type: PINGPONG});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		hue += elapsed * 80.0;
		if (hue >= 360.0)
			hue -= 360.0;
		pearl.color = FlxColor.fromHSL(hue, MAX_S, L);
	}

	public function setSaturation(percent:Float)
	{
		sat = MAX_S * percent;
	}

	override function kill()
	{
		pearl.alive = false;
		pearl.exists = false;
		pearlStand.alive = false;
		pearlStand.exists = true;
		this.alive = false;
		this.exists = true;
	}

	public function getPearlMidpoint():FlxPoint
		return pearl.getMidpoint();
}
