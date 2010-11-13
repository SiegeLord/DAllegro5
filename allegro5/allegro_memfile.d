module allegro5.allegro_memfile;

import allegro5.allegro;

extern (C)
{
	ALLEGRO_FILE* al_open_memfile(long size, void* mem);
	uint al_get_allegro_memfile_version();
}
