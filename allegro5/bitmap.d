module allegro5.bitmap;

import allegro5.color;
import allegro5.internal.da5;

extern (C)
{
	struct ALLEGRO_BITMAP {};
	
	enum ALLEGRO_PIXEL_FORMAT
	{
		ALLEGRO_PIXEL_FORMAT_ANY = 0,
		ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA,
		ALLEGRO_PIXEL_FORMAT_ARGB_8888,
		ALLEGRO_PIXEL_FORMAT_RGBA_8888,
		ALLEGRO_PIXEL_FORMAT_ARGB_4444,
		ALLEGRO_PIXEL_FORMAT_RGB_888,	/* 24 bit format */
		ALLEGRO_PIXEL_FORMAT_RGB_565,
		ALLEGRO_PIXEL_FORMAT_RGB_555,
		ALLEGRO_PIXEL_FORMAT_RGBA_5551,
		ALLEGRO_PIXEL_FORMAT_ARGB_1555,
		ALLEGRO_PIXEL_FORMAT_ABGR_8888,
		ALLEGRO_PIXEL_FORMAT_XBGR_8888,
		ALLEGRO_PIXEL_FORMAT_BGR_888,	/* 24 bit format */
		ALLEGRO_PIXEL_FORMAT_BGR_565,
		ALLEGRO_PIXEL_FORMAT_BGR_555,
		ALLEGRO_PIXEL_FORMAT_RGBX_8888,
		ALLEGRO_PIXEL_FORMAT_XRGB_8888,
		ALLEGRO_PIXEL_FORMAT_ABGR_F32,
		ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE,
		ALLEGRO_PIXEL_FORMAT_RGBA_4444,
		ALLEGRO_PIXEL_FORMAT_SINGLE_CHANNEL_8,
		ALLEGRO_NUM_PIXEL_FORMATS
	}
	
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

	/* Flags for the blitting functions */
	enum : int
	{
		ALLEGRO_FLIP_HORIZONTAL = 0x00001,
		ALLEGRO_FLIP_VERTICAL   = 0x00002
	}


	/*
	 * Locking flags
	 */
	enum : int
	{
		ALLEGRO_LOCK_READWRITE  = 0,
		ALLEGRO_LOCK_READONLY   = 1,
		ALLEGRO_LOCK_WRITEONLY  = 2
	}
	
	enum ALLEGRO_BLEND_MODE
	{
		ALLEGRO_ZERO = 0,
		ALLEGRO_ONE = 1,
		ALLEGRO_ALPHA = 2,
		ALLEGRO_INVERSE_ALPHA = 3,
		ALLEGRO_SRC_COLOR = 4,
		ALLEGRO_DST_COLOR = 5,
		ALLEGRO_INVERSE_SRC_COLOR = 6,
		ALLEGRO_INVERSE_DST_COLOR = 7
	}
	
	enum ALLEGRO_BLEND_OPERATIONS
	{
		ALLEGRO_ADD = 0,
		ALLEGRO_SRC_MINUS_DEST = 1,
		ALLEGRO_DEST_MINUS_SRC = 2,
		ALLEGRO_NUM_BLEND_OPERATIONS
	}
	
	struct ALLEGRO_LOCKED_REGION 
	{
		void* data;
		int format;
		int pitch;
		int pixel_size;
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
	ALLEGRO_BITMAP* al_create_custom_bitmap(int w, int h, bool function(ALLEGRO_BITMAP* bitmap, void* data) upload, void* data);
	void al_destroy_bitmap(ALLEGRO_BITMAP* bitmap);

	/* Blitting */
	void al_draw_bitmap(ALLEGRO_BITMAP* bitmap, float dx, float dy, int flags);
	void al_draw_bitmap_region(ALLEGRO_BITMAP* bitmap, float sx, float sy, float sw, float sh, float dx, float dy, int flags);
	void al_draw_scaled_bitmap(ALLEGRO_BITMAP* bitmap, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_rotated_bitmap(ALLEGRO_BITMAP* bitmap, float cx, float cy, float dx, float dy, float angle, int flags);
	void al_draw_scaled_rotated_bitmap(ALLEGRO_BITMAP* bitmap, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);
	
	/* Tinted blitting */
	void al_draw_tinted_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float dx, float dy, int flags);
	void al_draw_tinted_bitmap_region(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, int flags);
	void al_draw_tinted_scaled_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_tinted_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float angle, int flags);
	void al_draw_tinted_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);
	void al_draw_tinted_scaled_rotated_bitmap_region(ALLEGRO_BITMAP *bitmap, float sx, float sy, float sw, float sh, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);

	ALLEGRO_LOCKED_REGION* al_lock_bitmap(ALLEGRO_BITMAP* bitmap, int format, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region(ALLEGRO_BITMAP* bitmap, int x, int y, int width, int height, int format, int flags);
	void al_unlock_bitmap(ALLEGRO_BITMAP* bitmap);

	void al_put_pixel(int x, int y, ALLEGRO_COLOR color);
	void al_put_blended_pixel(int x, int y, ALLEGRO_COLOR color);
	int al_get_pixel_size(int format);

	/* Functions that return colors are below */

	/* Pixel unmapping */
	void al_unmap_rgb(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b);
	void al_unmap_rgba(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b, ubyte* a);
	void al_unmap_rgb_f(ALLEGRO_COLOR color, float* r, float* g, float* b);
	void al_unmap_rgba_f(ALLEGRO_COLOR color, float* r, float* g, float* b, float* a);
	int al_get_pixel_format_bits(int format);

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

	/* Miscellaneous */
	ALLEGRO_BITMAP* al_clone_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_convert_bitmaps();
	bool al_is_bitmap_locked(ALLEGRO_BITMAP* bitmap);

	/* Blending */
	void al_set_blender(int op, int source, int dest);
	void al_get_blender(int* op, int* source, int* dest);
	void al_set_separate_blender(int op, int source, int dest, int alpha_op, int alpha_source, int alpha_dest);
	void al_get_separate_blender(int* op, int* source, int* dest, int *alpha_op, int* alpha_src, int* alpha_dest);

	void _al_put_pixel(ALLEGRO_BITMAP* bitmap, int x, int y, ALLEGRO_COLOR color);
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

mixin(ColorWrapper("allegro5.color_ret.", "al_map_rgb", "ubyte r, ubyte g, ubyte b", "r, g, b"));
mixin(ColorWrapper("allegro5.color_ret.", "al_map_rgba", "ubyte r, ubyte g, ubyte b, ubyte a", "r, g, b, a"));
mixin(ColorWrapper("allegro5.color_ret.", "al_map_rgb_f", "float r, float g, float b", "r, g, b"));
mixin(ColorWrapper("allegro5.color_ret.", "al_map_rgba_f", "float r, float g, float b, float a", "r, g, b, a"));
mixin(ColorWrapper("allegro5.color_ret.", "al_get_pixel", "ALLEGRO_BITMAP* bitmap, int x, int y", "bitmap, x, y"));
