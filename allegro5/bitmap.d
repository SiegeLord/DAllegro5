module allegro5.bitmap;

import allegro5.color;

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
		ALLEGRO_NUM_PIXEL_FORMATS
	}
	
	/*
	 * Bitmap flags
	 */
	const int ALLEGRO_VIDEO_BITMAP        = 0x0000;

	const int ALLEGRO_MEMORY_BITMAP       = 0x0001;
	const int ALLEGRO_KEEP_BITMAP_FORMAT  = 0x0002;
	const int ALLEGRO_FORCE_LOCKING       = 0x0004;
	const int ALLEGRO_NO_PRESERVE_TEXTURE = 0x0008;
	const int ALLEGRO_ALPHA_TEST          = 0x0010;
	const int ALLEGRO_MIN_LINEAR          = 0x0040;
	const int ALLEGRO_MAG_LINEAR          = 0x0080;
	const int ALLEGRO_MIPMAP              = 0x0100;

	/* Flags for the blitting functions */
	const int ALLEGRO_FLIP_HORIZONTAL     = 0x00001;
	const int ALLEGRO_FLIP_VERTICAL       = 0x00002;


	/*
	 * Locking flags
	 */
	const int ALLEGRO_LOCK_READWRITE = 0;
	const int ALLEGRO_LOCK_READONLY  = 1;
	const int ALLEGRO_LOCK_WRITEONLY = 2;
	
	enum ALLEGRO_BLEND_MODE
	{
		ALLEGRO_ZERO = 0,
		ALLEGRO_ONE = 1,
		ALLEGRO_ALPHA = 2,
		ALLEGRO_INVERSE_ALPHA = 3
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
	void al_destroy_bitmap(ALLEGRO_BITMAP* bitmap);

	/* Blitting */
	void al_draw_bitmap(ALLEGRO_BITMAP* bitmap, float dx, float dy, int flags);
	void al_draw_bitmap_region(ALLEGRO_BITMAP* bitmap, float sx, float sy, float sw, float sh, float dx, float dy, int flags);
	void al_draw_scaled_bitmap(ALLEGRO_BITMAP* bitmap, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_rotated_bitmap(ALLEGRO_BITMAP* bitmap, float cx, float cy, float dx, float dy, float angle, int flags);
	void al_draw_rotated_scaled_bitmap(ALLEGRO_BITMAP* bitmap, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);
	
	/* Tinted blitting */
	void al_draw_tinted_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float dx, float dy, int flags);
	void al_draw_tinted_bitmap_region(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, int flags);
	void al_draw_tinted_scaled_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float sx, float sy, float sw, float sh, float dx, float dy, float dw, float dh, int flags);
	void al_draw_tinted_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float angle, int flags);
	void al_draw_tinted_scaled_rotated_bitmap(ALLEGRO_BITMAP *bitmap, ALLEGRO_COLOR tint, float cx, float cy, float dx, float dy, float xscale, float yscale, float angle, int flags);

	ALLEGRO_LOCKED_REGION* al_lock_bitmap(ALLEGRO_BITMAP* bitmap, int format, int flags);
	ALLEGRO_LOCKED_REGION* al_lock_bitmap_region(ALLEGRO_BITMAP* bitmap, int x, int y, int width, int height, int format, int flags);
	void al_unlock_bitmap(ALLEGRO_BITMAP* bitmap);

	void al_put_pixel(int x, int y, ALLEGRO_COLOR color);
	void al_put_blended_pixel(int x, int y, ALLEGRO_COLOR color);
	ALLEGRO_COLOR al_get_pixel(ALLEGRO_BITMAP* bitmap, int x, int y);
	int al_get_pixel_size(int format);

	/* Pixel mapping */
	ALLEGRO_COLOR al_map_rgb(char r, ubyte g, ubyte b);
	ALLEGRO_COLOR al_map_rgba(ubyte r, ubyte g, ubyte b, ubyte a);
	ALLEGRO_COLOR al_map_rgb_f(float r, float g, float b);
	ALLEGRO_COLOR al_map_rgba_f(float r, float g, float b, float a);

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
	void al_get_clipping_rectangle(int* x, int* y, int* w, int* h);

	/* Sub bitmaps */
	ALLEGRO_BITMAP * al_create_sub_bitmap(ALLEGRO_BITMAP* parent, int x, int y, int w, int h);
	bool al_is_sub_bitmap(ALLEGRO_BITMAP* bitmap);

	/* Miscellaneous */
	ALLEGRO_BITMAP * al_clone_bitmap(ALLEGRO_BITMAP* bitmap);
	bool al_is_bitmap_locked(ALLEGRO_BITMAP* bitmap);

	/* Blending */
	void al_set_blender(int op, int source, int dest, ALLEGRO_COLOR color);
	void al_get_blender(int* op, int* source, int* dest, ALLEGRO_COLOR* color);
	void al_set_separate_blender(int op, int source, int dest, int alpha_source, int alpha_dest, ALLEGRO_COLOR color);
	void al_get_separate_blender(int* op,int* source, int* dest, int* alpha_src, int* alpha_dest, ALLEGRO_COLOR* color);

	void _al_put_pixel(ALLEGRO_BITMAP* bitmap, int x, int y, ALLEGRO_COLOR color);
}
