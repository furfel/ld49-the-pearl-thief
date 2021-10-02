package effects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;

class Noise extends FlxTypedSpriteGroup<FlxSprite>
{
	private var sprites:Array<FlxSprite> = [];

	public function new()
	{
		super(0, 0);
		scrollFactor.set(0, 0);
		var tmp = new FlxSprite(0, 0, "assets/images/noise.png");
		for (_x in 0...Math.ceil(FlxG.width / tmp.width))
			for (_y in 0...Math.ceil(FlxG.height / tmp.height))
			{
				tmp = new FlxSprite(_x * tmp.width, _y * tmp.height, "assets/images/noise.png");
				sprites.push(tmp);
				add(tmp);
			}
	}

	/**
		Frame switching
	**/
	private var currentFrame:Int;

	private var maxElapsed = 0.02;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		maxElapsed -= elapsed;
		if (maxElapsed < 0)
		{
			maxElapsed = 0.02;
			currentFrame = (currentFrame + 1) % 7;
			for (i in 0...sprites.length)
			{
				sprites[i].flipX = (currentFrame + i % 5) % 2 == 0;
				sprites[i].flipY = (currentFrame + i % 3) == 1;
			}
		}
	}
}
