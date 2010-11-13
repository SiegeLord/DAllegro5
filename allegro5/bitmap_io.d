module allegro5.bitmap_io;

import allegro5.allegro;

extern(C)
{
	alias ALLEGRO_BITMAP* function(in char* filename) ALLEGRO_IIO_LOADER_FUNCTION;
	alias ALLEGRO_BITMAP* function(ALLEGRO_FILE* fp) ALLEGRO_IIO_FS_LOADER_FUNCTION;
	alias bool function(in char* filename, ALLEGRO_BITMAP* bitmap) ALLEGRO_IIO_SAVER_FUNCTION;
	alias bool function(ALLEGRO_FILE* fp, ALLEGRO_BITMAP* bitmap) ALLEGRO_IIO_FS_SAVER_FUNCTION;

	bool al_register_bitmap_loader(in char* ext, ALLEGRO_IIO_LOADER_FUNCTION loader);
	bool al_register_bitmap_saver(in char* ext, ALLEGRO_IIO_SAVER_FUNCTION saver);
	bool al_register_bitmap_loader_f(in char* ext, ALLEGRO_IIO_FS_LOADER_FUNCTION fs_loader);
	bool al_register_bitmap_saver_f(in char* ext, ALLEGRO_IIO_FS_SAVER_FUNCTION fs_saver);
	ALLEGRO_BITMAP* al_load_bitmap(in char* filename);
	ALLEGRO_BITMAP* al_load_bitmap_f(ALLEGRO_FILE* fp, in char* ident);
	bool al_save_bitmap(in char* filename, ALLEGRO_BITMAP* bitmap);
	bool al_save_bitmap_f(ALLEGRO_FILE* fp, in char* ident, ALLEGRO_BITMAP* bitmap);
}
