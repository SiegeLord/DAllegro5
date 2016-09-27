module allegro5.allegro_image;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_image");
}

import allegro5.allegro;

nothrow @nogc extern (C)
{
	bool al_init_image_addon();
	void al_shutdown_image_addon();
	uint al_get_allegro_image_version();
}
