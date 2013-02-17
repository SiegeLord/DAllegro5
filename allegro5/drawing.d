module allegro5.drawing;

import allegro5.color;

extern(C)
{
	/* Drawing primitives */
	void al_clear_to_color(ALLEGRO_COLOR color);
	void al_draw_pixel(float x, float y, ALLEGRO_COLOR color);
}
