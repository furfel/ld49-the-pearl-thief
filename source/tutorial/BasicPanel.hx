package tutorial;

import flixel.FlxG;
import flixel.FlxState;

class BasicPanel extends FlxState
{
	public var nextPanel:Class<BasicPanel>;

	public var switching = false;

	public function new()
	{
		super();
	}

	private var firstRun = true;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (firstRun)
		{
			firstRun = false;
			switching = true;
			camera.fade(0.15, true, () -> switching = false);
		}
		if (!switching && FlxG.keys.justPressed.ANY && nextPanel != null)
		{
			switching = true;
			camera.fade(0.18, () -> FlxG.switchState(Type.createInstance(nextPanel, [])));
		}
	}
}
