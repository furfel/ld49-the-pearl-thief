package;

import effects.Noise;
import flixel.FlxCamera;
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
	private var treetops:FlxTilemap;
	private var kraken:Badguy;

	override public function create()
	{
		super.create();
		FlxG.camera.antialiasing = true;
		forest = new Forest();
		this.bgColor = forest.getBgColor();
		add(trees = forest.getTrees());
		add(pearls = forest.getPearls());
		add(player = forest.getPlayer());
		add(treetops = forest.getTreetops());
		FlxG.worldBounds.copyFrom(forest.getBounds());
		camera.follow(player);
		add(kraken = new Badguy(pearls));

		add(new Indicator(player, kraken));

		add(new HUD(this));

		add(new Noise(this));
		add(new effects.DesaturateItems(this));

		#if FURFEL_DEBUG
		camera.zoom = 0.75;
		#end
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, trees);
		FlxG.collide(player, pearls);

		if (stability > getTargetStability())
			stability -= elapsed * .25;
	}

	private var stability = 1.0;

	public function getCurrentStability():Float
		return stability;

	private function getTargetStability():Float
		return (1.0 * pearls.countLiving()) / (1.0 * pearls.length);
}
