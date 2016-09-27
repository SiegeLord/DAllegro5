module allegro5.fullscreen_mode;

nothrow @nogc extern(C)
{
	struct ALLEGRO_DISPLAY_MODE
	{
		int width;
		int height;
		int format;
		int refresh_rate;
	}

	int al_get_num_display_modes();
	ALLEGRO_DISPLAY_MODE* al_get_display_mode(int index, ALLEGRO_DISPLAY_MODE* mode);
}
