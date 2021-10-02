package;

import effects.Noise;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.tile.FlxTilemap;
import pearl.Pearl;

class PlayState extends FlxState
{
	private var forest:Forest;
	private var player:Player;
	private var pearls:FlxTypedSpriteGroup<Pearl>;
	private var trees:FlxTilemap;

	override public function create()
	{
		super.create();
		FlxG.camera.antialiasing = true;
		forest = new Forest();
		this.bgColor = forest.getBgColor();
		add(trees = forest.getTrees());
		add(pearls = forest.getPearls());
		add(player = forest.getPlayer());
		add(forest.getTreetops());
		FlxG.worldBounds.copyFrom(forest.getBounds());
		camera.follow(player);
		// add(new Noise());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, trees);
		FlxG.collide(player, pearls);
	}
}
