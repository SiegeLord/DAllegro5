module allegro5.allegro_font;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_font");
}

import allegro5.allegro;

nothrow @nogc extern (C)
{
	struct ALLEGRO_FONT
	{
		void* data;
		int height;
		ALLEGRO_FONT *fallback;
		ALLEGRO_FONT_VTABLE* vtable;
	}

	struct ALLEGRO_FONT_VTABLE
	{
		int function(const(ALLEGRO_FONT)* f) font_height;
		int function(const(ALLEGRO_FONT)* f, int ch) char_length;
		int function(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text) text_length;
		int function(const(ALLEGRO_FONT)* f, int ch, int x, int y) render_char;
		int function(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text, int x, int y) render;
		void function(ALLEGRO_FONT* f) destroy;
		void function(const(ALLEGRO_FONT)* f,
		  const(ALLEGRO_USTR)* text, int* bbx, int* bby, int* bbw,
		  int* bbh, int* ascent, int* descent) get_text_dimensions;
		int function (ALLEGRO_FONT* font, int ranges_count, int* ranges) get_font_ranges;
		bool function(const ALLEGRO_FONT *f, int codepoint, int *bbx, int *bby, int *bbw, int *bbh) get_glyph_dimensions;
		int function(const ALLEGRO_FONT *font, int codepoint1, int codepoint2) get_glyph_advance;
	}

	enum
	{
		ALLEGRO_NO_KERNING       = -1,
		ALLEGRO_ALIGN_LEFT       = 0,
		ALLEGRO_ALIGN_CENTRE     = 1,
		ALLEGRO_ALIGN_CENTER     = 1,
		ALLEGRO_ALIGN_RIGHT      = 2,
		ALLEGRO_ALIGN_INTEGER    = 4,
	}

	bool al_register_font_loader(const(char)* ext, ALLEGRO_FONT* function(const(char)* filename, int size, int flags) load);
	ALLEGRO_FONT* al_load_bitmap_font(const(char)* filename);
	ALLEGRO_FONT* al_load_bitmap_font_flags(const(char)* filename, int flags);
	ALLEGRO_FONT* al_load_font(const(char)* filename, int size, int flags);

	ALLEGRO_FONT* al_grab_font_from_bitmap(ALLEGRO_BITMAP* bmp, int n, const(int)* ranges);
	ALLEGRO_FONT* al_create_builtin_font();

	void al_draw_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(ALLEGRO_USTR)* ustr);
	void al_draw_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* text);
	void al_draw_justified_text(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* text);
	void al_draw_justified_ustr(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(ALLEGRO_USTR)* text);
	void al_draw_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x, float y, int flags, const(char)* format, ...);
	void al_draw_justified_textf(const(ALLEGRO_FONT)* font, ALLEGRO_COLOR color, float x1, float x2, float y, float diff, int flags, const(char)* format, ...);
	int al_get_text_width(const(ALLEGRO_FONT)* f, const(char)* str);
	int al_get_ustr_width(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* ustr);
	int al_get_font_line_height(const(ALLEGRO_FONT)* f);
	int al_get_font_ascent(const(ALLEGRO_FONT)* f);
	int al_get_font_descent(const(ALLEGRO_FONT)* f);
	void al_destroy_font(ALLEGRO_FONT* f);
	void al_get_ustr_dimensions(const(ALLEGRO_FONT)* f, const(ALLEGRO_USTR)* text, int* bbx, int* bby, int* bbw, int* bbh);
	void al_get_text_dimensions(const(ALLEGRO_FONT)* f,	const(char)* text, int* bbx, int* bby, int* bbw, int* bbh);
	bool al_init_font_addon();
	void al_shutdown_font_addon();
	uint al_get_allegro_font_version();
	int al_get_font_ranges(ALLEGRO_FONT *font, int ranges_count, int* ranges);
	void al_draw_glyph(const ALLEGRO_FONT *font, ALLEGRO_COLOR color, float x, float y, int codepoint);
	int al_get_glyph_width(const ALLEGRO_FONT *f, int codepoint);
	bool al_get_glyph_dimensions(const ALLEGRO_FONT *f, int codepoint, int *bbx, int *bby, int *bbw, int *bbh);
	int al_get_glyph_advance(const ALLEGRO_FONT *f, int codepoint1, int codepoint2);
	void al_set_fallback_font(ALLEGRO_FONT *font, ALLEGRO_FONT *fallback);
	ALLEGRO_FONT* al_get_fallback_font(ALLEGRO_FONT *font);
}
