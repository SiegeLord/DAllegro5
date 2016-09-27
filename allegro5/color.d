module allegro5.color;

import allegro5.base;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	struct ALLEGRO_COLOR
	{
		float r, g, b, a;
	}

	enum ALLEGRO_PIXEL_FORMAT
	{
		ALLEGRO_PIXEL_FORMAT_ANY                  = 0,
		ALLEGRO_PIXEL_FORMAT_ANY_NO_ALPHA         = 1,
		ALLEGRO_PIXEL_FORMAT_ANY_WITH_ALPHA       = 2,
		ALLEGRO_PIXEL_FORMAT_ANY_15_NO_ALPHA      = 3,
		ALLEGRO_PIXEL_FORMAT_ANY_16_NO_ALPHA      = 4,
		ALLEGRO_PIXEL_FORMAT_ANY_16_WITH_ALPHA    = 5,
		ALLEGRO_PIXEL_FORMAT_ANY_24_NO_ALPHA      = 6,
		ALLEGRO_PIXEL_FORMAT_ANY_32_NO_ALPHA      = 7,
		ALLEGRO_PIXEL_FORMAT_ANY_32_WITH_ALPHA    = 8,
		ALLEGRO_PIXEL_FORMAT_ARGB_8888            = 9,
		ALLEGRO_PIXEL_FORMAT_RGBA_8888            = 10,
		ALLEGRO_PIXEL_FORMAT_ARGB_4444            = 11,
		ALLEGRO_PIXEL_FORMAT_RGB_888              = 12, /* 24 bit format */
		ALLEGRO_PIXEL_FORMAT_RGB_565              = 13,
		ALLEGRO_PIXEL_FORMAT_RGB_555              = 14,
		ALLEGRO_PIXEL_FORMAT_RGBA_5551            = 15,
		ALLEGRO_PIXEL_FORMAT_ARGB_1555            = 16,
		ALLEGRO_PIXEL_FORMAT_ABGR_8888            = 17,
		ALLEGRO_PIXEL_FORMAT_XBGR_8888            = 18,
		ALLEGRO_PIXEL_FORMAT_BGR_888              = 19, /* 24 bit format */
		ALLEGRO_PIXEL_FORMAT_BGR_565              = 20,
		ALLEGRO_PIXEL_FORMAT_BGR_555              = 21,
		ALLEGRO_PIXEL_FORMAT_RGBX_8888            = 22,
		ALLEGRO_PIXEL_FORMAT_XRGB_8888            = 23,
		ALLEGRO_PIXEL_FORMAT_ABGR_F32             = 24,
		ALLEGRO_PIXEL_FORMAT_ABGR_8888_LE         = 25,
		ALLEGRO_PIXEL_FORMAT_RGBA_4444            = 26,
		ALLEGRO_PIXEL_FORMAT_SINGLE_CHANNEL_8     = 27,
		ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT1 = 28,
		ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT3 = 29,
		ALLEGRO_PIXEL_FORMAT_COMPRESSED_RGBA_DXT5 = 30,
		ALLEGRO_NUM_PIXEL_FORMATS
	}

	/* Pixel unmapping */
	void al_unmap_rgb(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b);
	void al_unmap_rgba(ALLEGRO_COLOR color, ubyte* r, ubyte* g, ubyte* b, ubyte* a);
	void al_unmap_rgb_f(ALLEGRO_COLOR color, float* r, float* g, float* b);
	void al_unmap_rgba_f(ALLEGRO_COLOR color, float* r, float* g, float* b, float* a);

	int al_get_pixel_size(int format);
	int al_get_pixel_format_bits(int format);
	int al_get_pixel_block_size(int format);
	int al_get_pixel_block_width(int format);
	int al_get_pixel_block_height(int format);
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
mixin(ColorWrapper("allegro5.color_ret.", "al_premul_rgba", "ubyte r, ubyte g, ubyte b, ubyte a", "r, g, b, a"));
mixin(ColorWrapper("allegro5.color_ret.", "al_premul_rgba_f", "float r, float g, float b, float a", "r, g, b, a"));
