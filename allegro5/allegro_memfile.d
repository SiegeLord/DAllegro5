module allegro5.allegro_memfile;

import allegro5.allegro;

extern (C)
{
	ALLEGRO_FILE* al_open_memfile(void* mem, long size, in char* mode);
	uint al_get_allegro_memfile_version();
}
