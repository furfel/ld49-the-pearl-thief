package effects;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.system.FlxSound;

class Noise extends FlxTypedSpriteGroup<FlxSprite>
{
	private var sprites:Array<FlxSprite> = [];
	private var parent:PlayState;
	private var noiseSound:FlxSound;

	public static final ACTIVATION_TRESHOLD = 0.7;

	public function new(parent:PlayState)
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
		this.parent = parent;
		alpha = 0;
		noiseSound = new FlxSound().loadEmbedded("assets/sounds/noise.ogg");
		noiseSound.volume = 0;
	}

	/**
		Frame switching
	**/
	private var currentFrame:Int;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		currentFrame = (currentFrame + 1) % 7;
		for (i in 0...sprites.length)
		{
			sprites[i].flipX = (currentFrame + i % 5) % 2 == 0;
			sprites[i].flipY = (currentFrame + i % 3) == 1;
		}

		if (parent.getCurrentStability() <= ACTIVATION_TRESHOLD)
		{
			if (!noiseSound.playing)
				noiseSound.play();
			noiseSound.volume = (ACTIVATION_TRESHOLD - parent.getCurrentStability()) / ACTIVATION_TRESHOLD;
			alpha = (ACTIVATION_TRESHOLD - parent.getCurrentStability()) / ACTIVATION_TRESHOLD;
		}
	}
}
