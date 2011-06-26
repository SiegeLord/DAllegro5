module allegro5.allegro_ttf;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_ttf");
}

import allegro5.allegro;
import allegro5.allegro_font;

extern (C)
{
	ALLEGRO_FONT* al_load_ttf_font(in char* filename, int size, int flags);
	ALLEGRO_FONT* al_load_ttf_font_entry(ALLEGRO_FILE* file, in char* filename, int size, int flags);
	bool al_init_ttf_addon();
	void al_shutdown_ttf_addon();
	uint al_get_allegro_ttf_version();
}
