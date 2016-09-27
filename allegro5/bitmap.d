module allegro5.bitmap;

import allegro5.color;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	struct ALLEGRO_BITMAP {};
	
	/*
	 * Bitmap flags
	 */
	enum
	{
		ALLEGRO_MEMORY_BITMAP            = 0x0001,
		_ALLEGRO_KEEP_BITMAP_FORMAT      = 0x0002,	/* now a bitmap loader flag */
		ALLEGRO_FORCE_LOCKING            = 0x0004,
		ALLEGRO_NO_PRESERVE_TEXTURE      = 0x0008,
		_ALLEGRO_ALPHA_TEST              = 0x0010,  /* now a render state flag */
		_ALLEGRO_INTERNAL_OPENGL         = 0x0020,
		ALLEGRO_MIN_LINEAR               = 0x0040,
		ALLEGRO_MAG_LINEAR               = 0x0080,
		ALLEGRO_MIPMAP                   = 0x0100,
		_ALLEGRO_NO_PREMULTIPLIED_ALPHA  = 0x0200,	/* now a bitmap loader flag */
		ALLEGRO_VIDEO_BITMAP             = 0x0400,
		ALLEGRO_CONVERT_BITMAP           = 0x1000
	}
	
	void al_set_new_bitmap_format(int format);
	void al_set_new_bitmap_flags(int flags);
	int al_get_new_bitmap_format();
	int al_get_new_bitmap_flags();
	void al_add_new_bitmap_flag(int flag);

	int al_get_bitmap_width(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_height(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_format(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_flags(ALLEGRO_BITMAP* bitmap);

	ALLEGRO_BITMAP* al_create_bitmap(int w, int h);
	void al_destroy_bitmap(ALLEGRO_BITMAP* bitmap);

	void al_put_pixel(int x, int y, ALLEGRO_COLOR color);
	void al_put_blended_pixel(int x, int y, ALLEGRO_COLOR color);

	/* Masking */
	void al_convert_mask_to_alpha(ALLEGRO_BITMAP* bitmap, ALLEGRO_COLOR mask_color);

	/* Clipping */
	void al_set_clipping_rectangle(int x, int y, int width, int height);
	void al_reset_clipping_rectangle();
	void al_get_clipping_rectangle(int* x, int* y, int* w, int* h);

	/* Sub bitmaps */
	ALLEGRO_BITMAP* al_create_sub_bitmap(ALLEGRO_BITMAP* parent, int x, int y, int w, int h);
	bool al_is_sub_bitmap(ALLEGRO_BITMAP* bitmap);
	ALLEGRO_BITMAP* al_get_parent_bitmap(ALLEGRO_BITMAP* bitmap);
	int al_get_bitmap_x(ALLEGRO_BITMAP *bitmap);
	int al_get_bitmap_y(ALLEGRO_BITMAP *bitmap);
	void al_reparent_bitmap(ALLEGRO_BITMAP *bitmap,
		ALLEGRO_BITMAP *parent, int x, int y, int w, int h);

	/* Miscellaneous */
	ALLEGRO_BITMAP* al_clone_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_memory_bitmaps();
}

/*
 * MinGW 4.5 and below has a bizzare calling convention when returning
 * structs. These wrappers take care of the differences in calling convention.
 *
 * This issue does not exist in MSVC and maybe MinGW 4.6.
 */

static import allegro5.color_ret;

version(Windows)
{
	version(ALLEGRO_MSVC) {}
	else
	{
		version = ALLEGRO_SUB;
	}
}

mixin(ColorWrapper("allegro5.color_ret.", "al_get_pixel", "ALLEGRO_BITMAP* bitmap, int x, int y", "bitmap, x, y"));
