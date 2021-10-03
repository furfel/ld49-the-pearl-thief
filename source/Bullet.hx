package;

import flixel.FlxSprite;
import flixel.math.FlxPoint;

class Bullet extends FlxSprite
{
	public static final BULLET_SPEED = 200;

	public function new(X:Float, Y:Float, angle:Float)
	{
		super(X - 8, Y - 8);
		loadGraphic("assets/images/bullet.png", true, 16, 16);
		reuse(X, Y, angle);
	}

	public function reuse(X:Float, Y:Float, angle:Float)
	{
		reset(X - 8, Y - 8);
		this.angle = angle;
		this.velocity.set(BULLET_SPEED, 0).rotate(FlxPoint.weak(0, 0), angle);
		this.health = 1.6;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		this.health -= elapsed;
		if (this.health <= 0)
			this.kill();
	}
}
