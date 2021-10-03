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
	private var decorations:FlxTilemap;
	private var kraken:Badguy;
	private var bullets:FlxTypedSpriteGroup<Bullet>;

	override public function create()
	{
		super.create();
		FlxG.camera.antialiasing = true;
		forest = new Forest();
		this.bgColor = forest.getBgColor();
		add(decorations = forest.getDecor());
		add(trees = forest.getTrees());
		add(pearls = forest.getPearls());
		var shadow:BadguyShadow;
		add(shadow = new BadguyShadow());
		add(player = forest.getPlayer().setParent(this));
		add(bullets = new FlxTypedSpriteGroup<Bullet>(0, 0, 7));
		add(treetops = forest.getTreetops());
		FlxG.worldBounds.copyFrom(forest.getBounds());
		camera.follow(player);
		add(kraken = new Badguy(pearls, shadow));

		add(new HUD(this));
		add(new Indicator(player, kraken));

		add(new Noise(this));
		add(new effects.DesaturateItems(this));

		FlxG.sound.playMusic("assets/sounds/kraken.ogg");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, trees);
		FlxG.collide(player, pearls);
		FlxG.overlap(kraken, bullets, (k, b) ->
		{
			cast(b, Bullet).kill();
			kraken.interrupt();
		});
		FlxG.collide(bullets, trees, (b, t) ->
		{
			cast(b, Bullet).kill();
		});

		if (stability > getTargetStability())
			stability -= elapsed * .125;

		updateMusicVolume();
	}

	private function updateMusicVolume()
	{
		var d = kraken.getMidpoint().distanceTo(player.getMidpoint()) / 500.0;
		if (d > 1.0)
			d = 1.0;
		FlxG.sound.music.volume = 0.5 + d * 0.5;
	}

	private var stability = 1.0;

	public function getCurrentStability():Float
		return stability;

	private function getTargetStability():Float
		return (1.0 * pearls.countLiving()) / (1.0 * pearls.length);

	public function shoot(X:Float, Y:Float, angle:Float)
	{
		var av = bullets.getFirstAvailable();
		if (av == null)
			bullets.add(new Bullet(X, Y, angle));
		else
			av.reuse(X, Y, angle);
	}

	public function getHits():Int
		return kraken.hits;
}
