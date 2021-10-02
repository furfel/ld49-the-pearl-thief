package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		makeGraphic(32, 32, FlxColor.PURPLE);
	}

	public static final PLAYER_SPEED = 300;

	private static function isLeft():Bool
		return FlxG.keys.pressed.A || (FlxG.gamepads.firstActive != null && FlxG.gamepads.firstActive.pressed.DPAD_LEFT);

	private static function isUp():Bool
		return FlxG.keys.pressed.W || (FlxG.gamepads.firstActive != null && FlxG.gamepads.firstActive.pressed.DPAD_UP);

	private static function isDown():Bool
		return FlxG.keys.pressed.S || (FlxG.gamepads.firstActive != null && FlxG.gamepads.firstActive.pressed.DPAD_DOWN);

	private static function isRight():Bool
		return FlxG.keys.pressed.D || (FlxG.gamepads.firstActive != null && FlxG.gamepads.firstActive.pressed.DPAD_RIGHT);

	public function updateMovement()
	{
		if (isRight())
		{
			facing = FlxObject.RIGHT;
			velocity.set(PLAYER_SPEED, 0);
			if (isUp())
				velocity.rotate(FlxPoint.weak(0, 0), -45);
			else if (isDown())
				velocity.rotate(FlxPoint.weak(0, 0), 45);
		}
		else if (isLeft())
		{
			facing = FlxObject.LEFT;
			velocity.set(PLAYER_SPEED, 0);
			if (isUp())
				velocity.rotate(FlxPoint.weak(0, 0), 225);
			else if (isDown())
				velocity.rotate(FlxPoint.weak(0, 0), 135);
			else
				velocity.rotate(FlxPoint.weak(0, 0), 180);
		}
		else if (isUp())
		{
			facing = FlxObject.UP;
			velocity.set(PLAYER_SPEED, 0).rotate(FlxPoint.weak(0, 0), 270);
		}
		else if (isDown())
		{
			facing = FlxObject.DOWN;
			velocity.set(PLAYER_SPEED, 0).rotate(FlxPoint.weak(0, 0), 90);
		}
		else
			velocity.set(0, 0);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateMovement();
	}
}
