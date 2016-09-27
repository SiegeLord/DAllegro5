module allegro5.allegro_physfs;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_physfs");
}

nothrow @nogc extern (C)
{
	void al_set_physfs_file_interface();
	uint al_get_allegro_physfs_version();
}
