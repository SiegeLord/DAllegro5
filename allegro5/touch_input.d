module allegro5.touch_input;

import allegro5.base;
import allegro5.events;
import allegro5.display;

version (ALLEGRO_UNSTABLE)
	version = AllegroTouchUnstable;
version(ALLEGRO_INTERNAL_UNSTABLE)
	version = AllegroTouchUnstable;
version(ALLEGRO_SRC)
	version = AllegroTouchUnstable;

nothrow @nogc extern (C)
{
	/* Maximum number of simultaneous touches. */
	const size_t ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT = 16;

	struct ALLEGRO_TOUCH_INPUT {};
	
	struct ALLEGRO_TOUCH_STATE
	{
	   /* (id) An identifier of touch. If touch is valid this number is positive.
		* (x, y) Touch position on the screen in 1:1 resolution.
		* (dx, dy) Relative touch position.
		* (primary) True, if touch is a primary one (usually first one).
		* (display) Display at which the touch belong.
		*/
	   int id;
	   float x, y;
	   float dx, dy;
	   bool primary;
	   ALLEGRO_DISPLAY* display;
	}

	struct ALLEGRO_TOUCH_INPUT_STATE
	{
	   ALLEGRO_TOUCH_STATE[ALLEGRO_TOUCH_INPUT_MAX_TOUCH_COUNT] touches;
	}

	version (AllegroTouchUnstable)
	{
		enum ALLEGRO_MOUSE_EMULATION_MODE
		{
			ALLEGRO_MOUSE_EMULATION_NONE,
			ALLEGRO_MOUSE_EMULATION_TRANSPARENT,
			ALLEGRO_MOUSE_EMULATION_INCLUSIVE,
			ALLEGRO_MOUSE_EMULATION_EXCLUSIVE,
			ALLEGRO_MOUSE_EMULATION_5_0_x
		}
	}

	bool al_is_touch_input_installed();
	bool al_install_touch_input();
	void al_uninstall_touch_input();
	void al_get_touch_input_state(ALLEGRO_TOUCH_INPUT_STATE* ret_state);
	ALLEGRO_EVENT_SOURCE* al_get_touch_input_event_source();

	version (AllegroTouchUnstable)
	{
		void al_set_mouse_emulation_mode(int mode);
		int al_get_mouse_emulation_mode();
		ALLEGRO_EVENT_SOURCE* al_get_touch_input_mouse_emulation_event_source();
	}
}

