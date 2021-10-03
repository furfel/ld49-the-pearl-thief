package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	public static final ANGLES = [
		FlxObject.RIGHT => 0,
		FlxObject.RIGHT | FlxObject.DOWN => 45,
		FlxObject.DOWN => 90,
		FlxObject.DOWN | FlxObject.LEFT => 135,
		FlxObject.LEFT => 180,
		FlxObject.LEFT | FlxObject.UP => 225,
		FlxObject.UP => 270,
		FlxObject.UP | FlxObject.RIGHT => 315
	];

	public function new(X:Float, Y:Float)
	{
		super(X, Y);
		loadGraphic("assets/images/player.png", true, 32, 32);
		var _directions = ["down", "rightdown", "right", "rightup", "up"];
		for (_dir in 0..._directions.length)
		{
			var _d = _dir * 4;
			var _n = _directions[_dir];
			animation.add(_n, [0 + _d], 1);
			animation.add(_n + "shoot", [1 + _d], 1, false);
			animation.add(_n + "walk", [0 + _d, 2 + _d, 0 + _d, 3 + _d], 13);
		}
		for (_dir in ["down", "", "up"])
			for (_n in ["", "shoot", "walk"])
			{
				var an = animation.getByName("right" + _dir + _n);
				animation.add("left" + _dir + _n, an.frames.copy(), an.frameRate, an.looped, true);
			}

		setSize(20, 24);
		offset.set(6, 8);
	}

	private var parent:PlayState;

	public function setParent(parent:PlayState):Player
	{
		this.parent = parent;
		return this;
	}

	private function setAnimationTo()
	{
		var _name = "";
		if (facing & FlxObject.LEFT != 0)
			_name += "left";
		else if (facing & FlxObject.RIGHT != 0)
			_name += "right";
		if (facing & FlxObject.UP != 0)
			_name += "up";
		else if (facing & FlxObject.DOWN != 0)
			_name += "down";
		if (velocity.x != 0 || velocity.y != 0)
			_name += "walk";
		animation.play(_name);
	}

	public static final PLAYER_SPEED = 380;

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
			{
				velocity.rotate(FlxPoint.weak(0, 0), -45 + getRandomRotationOffset());
				facing |= FlxObject.UP;
			}
			else if (isDown())
			{
				facing |= FlxObject.DOWN;
				velocity.rotate(FlxPoint.weak(0, 0), 45 + getRandomRotationOffset());
			}
		}
		else if (isLeft())
		{
			facing = FlxObject.LEFT;
			velocity.set(PLAYER_SPEED, 0);
			if (isUp())
			{
				facing |= FlxObject.UP;
				velocity.rotate(FlxPoint.weak(0, 0), 225 + getRandomRotationOffset());
			}
			else if (isDown())
			{
				facing |= FlxObject.DOWN;
				velocity.rotate(FlxPoint.weak(0, 0), 135 + getRandomRotationOffset());
			}
			else
				velocity.rotate(FlxPoint.weak(0, 0), 180 + getRandomRotationOffset());
		}
		else if (isUp())
		{
			facing = FlxObject.UP;
			velocity.set(PLAYER_SPEED, 0).rotate(FlxPoint.weak(0, 0), 270 + getRandomRotationOffset());
		}
		else if (isDown())
		{
			facing = FlxObject.DOWN;
			velocity.set(PLAYER_SPEED, 0).rotate(FlxPoint.weak(0, 0), 90 + getRandomRotationOffset());
		}
		else
			velocity.set(0, 0);
	}

	private function getRandomRotationOffset():Float
	{
		var minmax = (1.0 - parent.getCurrentStability()) * 90;
		return FlxG.random.float(-minmax, minmax);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		updateMovement();
		setAnimationTo();
		if (parent != null && FlxG.keys.justPressed.SPACE && FlxG.random.float(0.0, 1.0) < parent.getCurrentStability())
			parent.shoot(getMidpoint().x, getMidpoint().y, ANGLES[facing] + getRandomRotationOffset() * 2);
	}
}
