module allegro5.clipboard;

import allegro5.base;
import allegro5.display;
import allegro5.utf8;

nothrow @nogc extern(C)
{
	char* al_get_clipboard_text(ALLEGRO_DISPLAY *display);
	bool al_set_clipboard_text(ALLEGRO_DISPLAY *display, const char *text);
	bool al_clipboard_has_text(ALLEGRO_DISPLAY *display);
}
