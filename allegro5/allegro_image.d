module allegro5.allegro_image;

import allegro5.allegro;

extern (C)
{
	bool al_init_image_addon();
	void al_shutdown_image_addon();
	uint al_get_allegro_image_version();
}
