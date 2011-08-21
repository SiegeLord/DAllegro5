module allegro5.color_ret;

import allegro5.color;
import allegro5.bitmap;

extern(C)
{
	ALLEGRO_COLOR al_get_pixel(ALLEGRO_BITMAP* bitmap, int x, int y);
	/* Pixel mapping */
	ALLEGRO_COLOR al_map_rgb(ubyte r, ubyte g, ubyte b);
	ALLEGRO_COLOR al_map_rgba(ubyte r, ubyte g, ubyte b, ubyte a);
	ALLEGRO_COLOR al_map_rgb_f(float r, float g, float b);
	ALLEGRO_COLOR al_map_rgba_f(float r, float g, float b, float a);
}
