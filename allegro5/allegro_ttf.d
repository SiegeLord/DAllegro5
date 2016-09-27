module allegro5.allegro_ttf;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_ttf");
}

import allegro5.allegro;
import allegro5.allegro_font;

nothrow @nogc extern (C)
{
	enum
	{
		ALLEGRO_TTF_NO_KERNING   = 1,
		ALLEGRO_TTF_MONOCHROME   = 2,
		ALLEGRO_TTF_NO_AUTOHINT  = 4
	}

	ALLEGRO_FONT* al_load_ttf_font(in char* filename, int size, int flags);
	ALLEGRO_FONT* al_load_ttf_font_f(ALLEGRO_FILE* file, in char* filename, int size, int flags);
	ALLEGRO_FONT* al_load_ttf_font_stretch(in char* filename, int w, int h, int flags);
	ALLEGRO_FONT* al_load_ttf_font_stretch_f(ALLEGRO_FILE *file, in char* filename, int w, int h, int flags);

	bool al_init_ttf_addon();
	void al_shutdown_ttf_addon();
	uint al_get_allegro_ttf_version();
}
