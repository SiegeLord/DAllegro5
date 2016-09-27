module allegro5.bitmap_io;

import allegro5.allegro;
import allegro5.internal.da5;

nothrow @nogc extern(C)
{
	/*
	* Bitmap loader flag
	*/
	enum
	{
		ALLEGRO_KEEP_BITMAP_FORMAT       = 0x0002,   /* was a bitmap flag in 5.0 */
		ALLEGRO_NO_PREMULTIPLIED_ALPHA   = 0x0200,   /* was a bitmap flag in 5.0 */
		ALLEGRO_KEEP_INDEX               = 0x0800
	}
	
	alias ALLEGRO_BITMAP* function(in char* filename) ALLEGRO_IIO_LOADER_FUNCTION;
	alias ALLEGRO_BITMAP* function(ALLEGRO_FILE* fp) ALLEGRO_IIO_FS_LOADER_FUNCTION;
	alias bool function(in char* filename, ALLEGRO_BITMAP* bitmap) ALLEGRO_IIO_SAVER_FUNCTION;
	alias bool function(ALLEGRO_FILE* fp, ALLEGRO_BITMAP* bitmap) ALLEGRO_IIO_FS_SAVER_FUNCTION;
	alias bool function(ALLEGRO_FILE *f) ALLEGRO_IIO_IDENTIFIER_FUNCTION;

	bool al_register_bitmap_loader(in char* ext, ALLEGRO_IIO_LOADER_FUNCTION loader);
	bool al_register_bitmap_saver(in char* ext, ALLEGRO_IIO_SAVER_FUNCTION saver);
	bool al_register_bitmap_loader_f(in char* ext, ALLEGRO_IIO_FS_LOADER_FUNCTION fs_loader);
	bool al_register_bitmap_saver_f(in char* ext, ALLEGRO_IIO_FS_SAVER_FUNCTION fs_saver);
	bool al_register_bitmap_identifier(const char *ext,
		ALLEGRO_IIO_IDENTIFIER_FUNCTION identifier);
	ALLEGRO_BITMAP* al_load_bitmap(in char* filename);
	ALLEGRO_BITMAP* al_load_bitmap_flags(in char* filename, int flags);
	ALLEGRO_BITMAP* al_load_bitmap_f(ALLEGRO_FILE* fp, in char* ident);
	ALLEGRO_BITMAP* al_load_bitmap_flags_f(ALLEGRO_FILE* fp, in char* ident, int flags);
	bool al_save_bitmap(in char* filename, ALLEGRO_BITMAP* bitmap);
	bool al_save_bitmap_f(ALLEGRO_FILE* fp, in char* ident, ALLEGRO_BITMAP* bitmap);
	const_char* al_identify_bitmap_f(ALLEGRO_FILE *fp);
	const_char* al_identify_bitmap(const_char* filename);
}
