module allegro5.allegro_color_ret;

import allegro5.allegro;

nothrow @nogc extern(C)
{
	ALLEGRO_COLOR al_color_yuv(float y, float u, float v);
	ALLEGRO_COLOR al_color_cmyk(float c, float m, float y, float k);
	ALLEGRO_COLOR al_color_hsl(float h, float s, float l);
	ALLEGRO_COLOR al_color_hsv(float h, float s, float v);
	ALLEGRO_COLOR al_color_name(in char* name);
	ALLEGRO_COLOR al_color_html(in char* string);
}
