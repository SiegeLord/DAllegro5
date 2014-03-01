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
		int function(in ALLEGRO_FONT* f) font_ascent;
		int function(in ALLEGRO_FONT* f) font_descent;
		int function(in ALLEGRO_FONT* f, int ch) char_length;
		int function(in ALLEGRO_FONT* f, in ALLEGRO_USTR* text) text_length;
		int function(in ALLEGRO_FONT* f, ALLEGRO_COLOR color, int ch, float x, float y) render_char;
		int function(in ALLEGRO_FONT* f, ALLEGRO_COLOR color, in ALLEGRO_USTR* text, float x, float y) render;
		void function(ALLEGRO_FONT* f) destroy;
		void function(in ALLEGRO_FONT* f,
		  in ALLEGRO_USTR* text, int* bbx, int* bby, int* bbw, int* bbh) get_text_dimensions;
		int function (ALLEGRO_FONT* font, int ranges_count, int* ranges) get_font_ranges;
	}

	enum
	{
		ALLEGRO_ALIGN_LEFT       = 0,
		ALLEGRO_ALIGN_CENTRE     = 1,
		ALLEGRO_ALIGN_CENTER     = 1,
		ALLEGRO_ALIGN_RIGHT      = 2,
		ALLEGRO_ALIGN_INTEGER    = 4
	}

	bool al_register_font_loader(in char* ext, ALLEGRO_FONT* function(in char* filename, int size, int flags) load);
	ALLEGRO_FONT* al_load_bitmap_font(in char* filename);
	ALLEGRO_FONT* al_load_bitmap_font_flags(in char* filename, int flags);
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
	void al_get_ustr_dimensions(in ALLEGRO_FONT* f, in ALLEGRO_USTR* text, int* bbx, int* bby, int* bbw, int* bbh);
	void al_get_text_dimensions(in ALLEGRO_FONT* f,	in char* text, int* bbx, int* bby, int* bbw, int* bbh);
	bool al_init_font_addon();
	void al_shutdown_font_addon();
	uint al_get_allegro_font_version();
	int al_get_font_ranges(ALLEGRO_FONT *font, int ranges_count, int* ranges);
}
