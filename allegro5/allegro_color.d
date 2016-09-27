module allegro5.allegro_color;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_color");
}

import allegro5.allegro;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	uint al_get_allegro_color_version();

	void al_color_hsv_to_rgb(float hue, float saturation, float value, float* red, float* green, float* blue);
	void al_color_rgb_to_hsl(float red, float green, float blue, float* hue, float* saturation, float* lightness);
	void al_color_rgb_to_hsv(float red, float green, float blue, float* hue, float* saturation, float* value);
	void al_color_hsl_to_rgb(float hue, float saturation, float lightness, float* red, float* green, float* blue);
	int al_color_name_to_rgb(in char* name, float* r, float* g, float* b);
	const_char* al_color_rgb_to_name(float r, float g, float b);
	void al_color_cmyk_to_rgb(float cyan, float magenta, float yellow,  float key, float* red, float* green, float* blue);
	void al_color_rgb_to_cmyk(float red, float green, float blue, float* cyan, float* magenta, float* yellow, float* key);
	void al_color_yuv_to_rgb(float y, float u, float v,  float* red, float* green, float* blue);
	void al_color_rgb_to_yuv(float red, float green, float blue, float* y, float* u, float* v);
	void al_color_rgb_to_html(float red, float green, float blue,  char* string);
	void al_color_html_to_rgb(in char* string, float* red, float* green, float* blue);
}
	
static import allegro5.allegro_color_ret;

version(Windows)
{
	version(ALLEGRO_MSVC) {}
	else
	{
		version = ALLEGRO_SUB;
	}
}

mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_yuv", "float y, float u, float v", "y, u, v"));
mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_cmyk", "float c, float m, float y, float k", "c, m, y, k"));
mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_hsl", "float h, float s, float l", "h, s, l"));
mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_hsv", "float h, float s, float v", "h, s, v"));
mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_name", "in char* name", "name"));
mixin(ColorWrapper("allegro5.allegro_color_ret.", "al_color_html", "in char* string", "string"));

