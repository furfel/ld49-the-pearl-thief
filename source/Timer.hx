package;

import flixel.text.FlxText;
import flixel.util.FlxColor;

class Timer extends FlxText
{
	public function new(X:Float, Y:Float, textSize:Int)
	{
		super(X, Y, "00:00:00", textSize);
		setBorderStyle(OUTLINE, FlxColor.BLACK, 2, 1);
	}

	public function setTime(seconds:Float)
	{
		var i_seconds = Math.floor(seconds);
		var s = i_seconds % 60;
		var m = Math.floor((i_seconds - s) / 60) % 60;
		var h = Math.floor((i_seconds - m * 60 - s) / 3600);
		var ss = s < 10 ? "0" + s : "" + s;
		var sm = m < 10 ? "0" + m : "" + m;
		var sh = h < 10 ? "0" + h : "" + h;
		text = sh + ":" + sm + ":" + ss;
	}
}
