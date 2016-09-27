module allegro5.allegro_acodec;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_acodec");
}

nothrow @nogc extern (C)
{
	bool al_init_acodec_addon();
	uint al_get_allegro_acodec_version();
}
