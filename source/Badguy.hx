package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxAngle;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import pearl.Pearl;

class Badguy extends FlxSprite
{
	public static final STATE_FLYING_AROUND = 0;
	#if FURFEL_DEBUG
	public static final FLYING_AROUND_WAIT_MIN = 1.0;
	public static final FLYING_AROUND_WAIT_MAX = 2.0;
	#else
	public static final FLYING_AROUND_WAIT_MIN = 3.0;
	public static final FLYING_AROUND_WAIT_MAX = 12.0;
	#end
	public static final STATE_FLYING_FOR_PEARL = 1;
	#if FURFEL_DEBUG
	public static final TAKING_PEARL_WAIT_MIN = 1.0;
	public static final TAKING_PEARL_WAIT_MAX = 2.0;
	#else
	public static final TAKING_PEARL_WAIT_MIN = 3.0;
	public static final TAKING_PEARL_WAIT_MAX = 6.0;
	#end
	public static final STATE_TAKING_PEARL = 2;
	public static final STATE_FLYING_AWAY = 3;

	private var flyaroundDirection = 1;
	private var targetPearl:Pearl;

	private var pearls:FlxTypedSpriteGroup<pearl.Pearl>;
	private var worldCentralPoint:FlxPoint;
	private var angleAroundWorld:Float;
	private var radiusAroundWorld:Float;

	public function new(pearls:FlxTypedSpriteGroup<pearl.Pearl>)
	{
		super(0, 0);
		loadGraphic("assets/images/kraken.png", true, 32, 32);
		animation.add("down", [0, 1, 2, 1], 7);
		animation.add("right", [3, 4, 5, 4], 7);
		animation.add("left", [3, 4, 5, 4], 7, true, true);
		animation.add("up", [6, 7, 6, 8], 7);
		animation.play("down");
		this.pearls = pearls;
		worldCentralPoint = new FlxPoint(FlxG.worldBounds.x + FlxG.worldBounds.width / 2, FlxG.worldBounds.y + FlxG.worldBounds.height / 2);
		radiusAroundWorld = FlxG.worldBounds.height / 2;
		angleAroundWorld = FlxG.random.float(0, 360.0);
	}

	private var state = STATE_FLYING_AROUND;

	private var waitTime = 2.0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (waitTime > 0)
			waitTime -= elapsed;

		if (waitTime <= 0)
		{
			updateState();
		}

		switch (state)
		{
			case STATE_FLYING_AROUND:
				updateFlyaroundPosition(elapsed);
		}
	}

	private function updateState()
	{
		switch (state)
		{
			case STATE_FLYING_AROUND:
				getPearl();
			case STATE_TAKING_PEARL:
				flyAway();
		}
	}

	private var flyTween:FlxTween;
	private var interrupted = false;

	private function getPearl()
	{
		interrupted = false;
		state = STATE_FLYING_FOR_PEARL;
		targetPearl = findNearestPearl();
		var destination = targetPearl.getPearlMidpoint().add(-width / 2, -height / 2);
		changeAnimation(destination.x, destination.y);
		flyTween = FlxTween.linearMotion(this, this.x, this.y, destination.x, destination.y, 400, false, {
			ease: FlxEase.cubeIn,
			onComplete: takePearl
		});
	}

	private function findNearestPearl():Pearl
	{
		var nearest:Pearl = null;
		pearls.forEachAlive(p -> if (nearest == null) nearest = p; else
		{
			if (p.getGraphicMidpoint().distanceTo(this.getGraphicMidpoint()) < nearest.getGraphicMidpoint().distanceTo(this.getGraphicMidpoint()))
				nearest = p;
		});
		return nearest;
	}

	private function takePearl(t:FlxTween)
	{
		waitTime = FlxG.random.float(TAKING_PEARL_WAIT_MIN, TAKING_PEARL_WAIT_MAX);
		state = STATE_TAKING_PEARL;
	}

	private function flyAway()
	{
		state = STATE_FLYING_AWAY;
		if (!interrupted && targetPearl != null)
		{
			targetPearl.kill();
		}
		angleAroundWorld = selectSomeNearAngle();
		var x = FlxMath.fastCos(FlxAngle.TO_RAD * angleAroundWorld) * radiusAroundWorld + worldCentralPoint.x;
		var y = FlxMath.fastSin(FlxAngle.TO_RAD * angleAroundWorld) * radiusAroundWorld + worldCentralPoint.y;
		changeAnimation(x, y);
		flyTween = FlxTween.linearMotion(this, this.x, this.y, x, y, 200.0, false, {ease: FlxEase.cubeIn, onComplete: flyAround});
	}

	/**
		Select an angle in the quarter you are in so the flight is not so long
	**/
	private function selectSomeNearAngle():Float
	{
		if (x < worldCentralPoint.x && y < worldCentralPoint.y)
			return FlxG.random.float(180.0, 270.0);
		else if (x < worldCentralPoint.x && y > worldCentralPoint.y)
			return FlxG.random.float(90.0, 180.0);
		else if (x > worldCentralPoint.x && y > worldCentralPoint.y)
			return FlxG.random.float(0.0, 90.0);
		else
			return FlxG.random.float(270.0, 359.0);
	}

	private function changeAnimation(_x:Float, _y:Float)
	{
		var dX = _x - x;
		var dY = _y - y;
		if (Math.abs(dX) > Math.abs(dY))
		{
			if (dX < 0)
				animation.play("left");
			else
				animation.play("right");
		}
		else
		{
			if (dY < 0)
				animation.play("up");
			else
				animation.play("down");
		}
	}

	private function flyAround(t:FlxTween)
	{
		state = STATE_FLYING_AROUND;
		waitTime = FlxG.random.float(FLYING_AROUND_WAIT_MIN, FLYING_AROUND_WAIT_MAX);
		flyaroundDirection = FlxG.random.float() < 0.5 ? -1 : 1;
	}

	private function updateFlyaroundPosition(elasped:Float)
	{
		angleAroundWorld += flyaroundDirection * elasped * 40.0;
		var _x = FlxMath.fastCos(FlxAngle.TO_RAD * angleAroundWorld) * radiusAroundWorld + worldCentralPoint.x;
		var _y = FlxMath.fastSin(FlxAngle.TO_RAD * angleAroundWorld) * radiusAroundWorld + worldCentralPoint.y;
		changeAnimation(_x, _y);
		this.x = _x;
		this.y = _y;
	}

	public function interrupt()
	{
		interrupted = true;
	}
}
