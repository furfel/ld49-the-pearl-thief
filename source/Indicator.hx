package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxAngle;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;

class Indicator extends FlxSprite
{
	private var radius = 2.0;
	private var player:Player;
	private var badguy:Badguy;

	public function new(player:Player, badguy:Badguy)
	{
		super();
		makeGraphic(24, 24, FlxColor.TRANSPARENT);
		FlxSpriteUtil.drawTriangle(this, 0, 0, 24, FlxColor.fromRGB(230, 120, 190, 210));
		scrollFactor.set(0, 0);
		radius = Math.min(FlxG.width, FlxG.height) / 2.0 * 0.95;
		this.player = player;
		this.badguy = badguy;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		var angleAroundScreen = FlxAngle.angleBetween(player, badguy);
		x = FlxG.width / 2 + Math.cos(angleAroundScreen) * radius;
		y = FlxG.height / 2 + Math.sin(angleAroundScreen) * radius;
		angle = FlxAngle.TO_DEG * angleAroundScreen + 90;
	}
}
