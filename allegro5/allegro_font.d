module allegro5.allegro_font;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_font");
}

import allegro5.allegro;

extern (C)
{
	struct ALLEGRO_FONT
	{
		void* data;
		int height;
		ALLEGRO_FONT_VTABLE* vtable;
	}

	struct ALLEGRO_FONT_VTABLE
	{
		int function(in ALLEGRO_FONT* f) font_height;
		int function(in ALLEGRO_FONT* f, int ch) char_length;
		int function(in ALLEGRO_FONT* f, in ALLEGRO_USTR* text) text_length;
		int function(in ALLEGRO_FONT* f, int ch, int x, int y) render_char;
		int function(in ALLEGRO_FONT* f, in ALLEGRO_USTR* text, int x, int y) render;
		void function(ALLEGRO_FONT* f) destroy;
		void function(in ALLEGRO_FONT* f,
		  in ALLEGRO_USTR* text, int* bbx, int* bby, int* bbw,
		  int* bbh, int* ascent, int* descent) get_text_dimensions;
	}

	enum
	{
		ALLEGRO_ALIGN_LEFT   = 0,
		ALLEGRO_ALIGN_CENTRE = 1,
		ALLEGRO_ALIGN_RIGHT  = 2
	}

	bool al_register_font_loader(in char* ext, ALLEGRO_FONT* function(in char* filename, int size, int flags) load);
	ALLEGRO_FONT* al_load_bitmap_font(in char* filename);
	ALLEGRO_FONT* al_load_font(in char* filename, int size, int flags);

	ALLEGRO_FONT* al_grab_font_from_bitmap(ALLEGRO_BITMAP* bmp, int n, in int* ranges);
	ALLEGRO_FONT* al_create_builtin_font();

	void al_draw_ustr(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x, float y, int flags, in ALLEGRO_USTR* ustr);
	void al_draw_text(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x, float y, int flags, in char* text);
	void al_draw_justified_text(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, in char* text);
	void al_draw_justified_ustr(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, in ALLEGRO_USTR* text);
	void al_draw_textf(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x, float y, int flags, in char* format, ...);
	void al_draw_justified_textf(in ALLEGRO_FONT* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, in char* format, ...);
	int al_get_text_width(in ALLEGRO_FONT* f, in char* str);
	int al_get_ustr_width(in ALLEGRO_FONT* f, in ALLEGRO_USTR* ustr);
	int al_get_font_line_height(in ALLEGRO_FONT* f);
	int al_get_font_ascent(in ALLEGRO_FONT* f);
	int al_get_font_descent(in ALLEGRO_FONT* f);
	void al_destroy_font(ALLEGRO_FONT* f);
	void al_get_ustr_dimensions(in ALLEGRO_FONT* f, in ALLEGRO_USTR* text, int* bbx, int* bby, int* bbw, int* bbh, int* ascent, int* descent);
	void al_get_text_dimensions(in ALLEGRO_FONT* f,	in char* text, int* bbx, int* bby, int* bbw, int* bbh, int* ascent, int* descent);
	void al_init_font_addon();
	void al_shutdown_font_addon();
	uint al_get_allegro_font_version();
}
