module allegro5.allegro_color;

import allegro5.allegro;

extern (C)
{
	uint al_get_allegro_color_version();

	void al_color_hsv_to_rgb(float hue, float saturation, float value, float* red, float* green, float* blue);
	void al_color_rgb_to_hsl(float red, float green, float blue, float* hue, float* saturation, float* lightness);
	void al_color_rgb_to_hsv(float red, float green, float blue, float* hue, float* saturation, float* value);
	void al_color_hsl_to_rgb(float hue, float saturation, float lightness, float* red, float* green, float* blue);
	int al_color_name_to_rgb(in char* name, float* r, float* g, float* b);
	char* al_color_rgb_to_name(float r, float g, float b);
	void al_color_cmyk_to_rgb(float cyan, float magenta, float yellow,  float key, float* red, float* green, float* blue);
	void al_color_rgb_to_cmyk(float red, float green, float blue, float* cyan, float* magenta, float* yellow, float* key);
	void al_color_yuv_to_rgb(float y, float u, float v,  float* red, float* green, float* blue);
	void al_color_rgb_to_yuv(float red, float green, float blue, float* y, float* u, float* v);
	void al_color_rgb_to_html(float red, float green, float blue,  char* string);
	void al_color_html_to_rgb(in char* string, float* red, float* green, float* blue);
	ALLEGRO_COLOR al_color_yuv(float y, float u, float v);
	ALLEGRO_COLOR al_color_cmyk(float c, float m, float y, float k);
	ALLEGRO_COLOR al_color_hsl(float h, float s, float l);
	ALLEGRO_COLOR al_color_hsv(float h, float s, float v);
	ALLEGRO_COLOR al_color_name(in char* name);
	ALLEGRO_COLOR al_color_html(in char* string);
}
