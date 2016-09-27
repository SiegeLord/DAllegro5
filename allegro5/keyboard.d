module allegro5.keyboard;

import allegro5.keycodes;
import allegro5.display;
import allegro5.events;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	struct ALLEGRO_KEYBOARD {};

	struct ALLEGRO_KEYBOARD_STATE
	{
		/* public */
		ALLEGRO_DISPLAY* display;
		/* internal */
		uint[(ALLEGRO_KEY_MAX + 31) / 32] __key_down__internal__;
	}
	
	bool  al_is_keyboard_installed();
	bool  al_install_keyboard();
	void  al_uninstall_keyboard();

	bool  al_set_keyboard_leds(int leds);

	const_char* al_keycode_to_name(int keycode);

	void  al_get_keyboard_state(ALLEGRO_KEYBOARD_STATE* ret_state);
	bool  al_key_down          (in ALLEGRO_KEYBOARD_STATE* state, int keycode);

	ALLEGRO_EVENT_SOURCE* al_get_keyboard_event_source();
}
