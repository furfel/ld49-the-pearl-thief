package;

import flixel.addons.editors.tiled.*;
import flixel.addons.tile.FlxTilemapExt;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxRect;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import pearl.Pearl;

class Forest
{
	private var tiled_map:TiledMap;
	private var treesTilemap:FlxTilemap;
	private var treesTopTilemap:FlxTilemap;
	private var pearls:FlxTypedSpriteGroup<pearl.Pearl> = new FlxTypedSpriteGroup<Pearl>();
	private var player:Player;
	private var bounds:FlxRect;

	public function new()
	{
		tiled_map = new TiledMap("assets/data/forest.tmx");
		var gid = tiled_map.getTileSet("trees").firstGID;

		var trees = cast(tiled_map.getLayer("trees"), TiledTileLayer);
		treesTilemap = new FlxTilemap();
		treesTilemap.loadMapFromArray(trees.tileArray, trees.width, trees.height, "assets/images/tree.png", 32, 32, OFF, gid, 1, 1);

		var trees_top = cast(tiled_map.getLayer("trees_top"), TiledTileLayer);
		treesTopTilemap = new FlxTilemap();
		treesTopTilemap.loadMapFromArray(trees_top.tileArray, trees_top.width, trees_top.height, "assets/images/tree.png", 32, 32, OFF, gid, 1, 1);

		var pearls_layer = cast(tiled_map.getLayer("pearls"), TiledObjectLayer);
		for (p in pearls_layer.objects)
			pearls.add(new Pearl(p.x, p.y));

		var player_layer = cast(tiled_map.getLayer("player"), TiledObjectLayer);
		player = new Player(player_layer.objects[0].x, player_layer.objects[0].y);

		bounds = new FlxRect(0, 0, tiled_map.fullWidth, tiled_map.fullHeight);
	}

	public function getTrees():FlxTilemap
		return treesTilemap;

	public function getTreetops():FlxTilemap
		return treesTopTilemap;

	public function getPearls():FlxTypedSpriteGroup<Pearl>
		return pearls;

	public function getPlayer():Player
		return player;

	public function getBounds():FlxRect
		return bounds;

	public function getBgColor():FlxColor
		return tiled_map.backgroundColor;
}
