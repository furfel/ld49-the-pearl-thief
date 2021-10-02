package pearl;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;

class Pearl extends FlxTypedSpriteGroup<FlxSprite>
{
	private var pearl:FlxSprite;
	private var pearlStand:FlxSprite;

	public function new(X:Float, Y:Float, _color:Int)
	{
		super(X, Y);
		add(pearlStand = new FlxSprite(X, Y, "assets/images/pearlstand.png"));
		add(pearl = new FlxSprite(X, Y, "assets/images/pearl.png"));
		pearl.color = _color;
		pearl.x = pearlStand.x + pearlStand.width / 2 - pearl.width / 2;
		pearl.y = pearlStand.y - pearl.height;
		animate();
	}

	private var tween:FlxTween;

	private function animate()
	{
		tween = FlxTween.linearMotion(pearl, pearl.x, pearl.y + 1, pearl.x, pearl.y - 3, 0.4, true, {ease: FlxEase.cubeInOut, type: PINGPONG});
	}
}
