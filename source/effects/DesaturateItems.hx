package effects;

import flixel.FlxBasic;
import flixel.FlxG;
import flixel.graphics.tile.FlxGraphicsShader;
import flixel.util.FlxColorTransformUtil;
import openfl.display.GraphicsShader;

class DesaturateItems extends FlxBasic
{
	private var parent:PlayState;

	public static final ACTIVATION_TRESHOLD = 0.6;

	private var sh:FurfelMegaShader;

	@:access(PlayState)
	public function new(parent:PlayState)
	{
		super();
		this.parent = parent;
		sh = new FurfelMegaShader();
		sh.data.saturation.value = [1.0];
		sh.data.skew.value = [0.0];
		sh.data.timeskew.value = [0.0];
		this.parent.trees.shader = sh;
		this.parent.treetops.shader = sh;
	}

	private var phase = 0.0;

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		phase += elapsed;
		if (phase > 6.5)
			phase -= 6.5;
		if (parent.getCurrentStability() < ACTIVATION_TRESHOLD)
		{
			var level = 1.0 - (ACTIVATION_TRESHOLD - parent.getCurrentStability()) / ACTIVATION_TRESHOLD;
			sh.data.saturation.value = [level];
			sh.data.skew.value = [1.0 - level];
			sh.data.timeskew.value = [phase];
		}
	}
}

class FurfelMegaShader extends FlxGraphicsShader
{
	@:glVertexSource("
    #pragma header
    uniform float saturation;
    uniform float skew;
	uniform float timeskew;
    	attribute float alpha;
		attribute vec4 colorMultiplier;
		attribute vec4 colorOffset;
		uniform bool hasColorTransform;
    void main(void)
		{
			#pragma body
			
			openfl_Alphav = openfl_Alpha * alpha;
			
			if (hasColorTransform)
			{
				openfl_ColorOffsetv = colorOffset / 255.0;
				openfl_ColorMultiplierv = colorMultiplier;
			}
		}
    ")
	@:glFragmentHeader("
        uniform float saturation;
        uniform float skew;
		uniform float timeskew;

        // All components are in the range [0…1], including hue.
    vec3 rgb2hsv(vec3 c)
    {
        vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
        vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
        vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

        float d = q.x - min(q.w, q.y);
        float e = 1.0e-10;
        return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
    }

    // All components are in the range [0…1], including hue.
    vec3 hsv2rgb(vec3 c)
    {
        vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
        vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
        return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
    }
		vec4 furfel_texture2D(sampler2D bitmap, vec2 coord)
		{
            float x_coord = clamp(coord.x - sin(coord.y * 18.0 + timeskew) * skew * 0.1, 0.0, 1.0);
            coord.x = x_coord;
			vec4 color = flixel_texture2D(bitmap, coord);
            vec3 hsvcolor = rgb2hsv(color.rgb);
            hsvcolor.y *= saturation * 0.5;
            return vec4(hsv2rgb(hsvcolor), color.a);
		}
	")
	@:glFragmentSource("
		#pragma header
		
		void main(void)
		{
			gl_FragColor = furfel_texture2D(bitmap, openfl_TextureCoordv);
		}")
	public function new()
	{
		super();
	}
}
