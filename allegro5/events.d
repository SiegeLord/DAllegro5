module allegro5.events;

import allegro5.altime;
import allegro5.base;
import allegro5.display;
import allegro5.joystick;
import allegro5.mouse;
import allegro5.keyboard;
import allegro5.timer;
import allegro5.touch_input;

version (Tango) {
	import tango.stdc.stdint;
}
else {
	import std.stdint;
}

nothrow @nogc extern (C)
{
	alias uint ALLEGRO_EVENT_TYPE;

	enum
	{
		ALLEGRO_EVENT_JOYSTICK_AXIS               =  1,
		ALLEGRO_EVENT_JOYSTICK_BUTTON_DOWN        =  2,
		ALLEGRO_EVENT_JOYSTICK_BUTTON_UP          =  3,
		ALLEGRO_EVENT_JOYSTICK_CONFIGURATION      =  4,

		ALLEGRO_EVENT_KEY_DOWN                    = 10,
		ALLEGRO_EVENT_KEY_CHAR                    = 11,
		ALLEGRO_EVENT_KEY_UP                      = 12,

		ALLEGRO_EVENT_MOUSE_AXES                  = 20,
		ALLEGRO_EVENT_MOUSE_BUTTON_DOWN           = 21,
		ALLEGRO_EVENT_MOUSE_BUTTON_UP             = 22,
		ALLEGRO_EVENT_MOUSE_ENTER_DISPLAY         = 23,
		ALLEGRO_EVENT_MOUSE_LEAVE_DISPLAY         = 24,
		ALLEGRO_EVENT_MOUSE_WARPED                = 25,

		ALLEGRO_EVENT_TIMER                       = 30,

		ALLEGRO_EVENT_DISPLAY_EXPOSE              = 40,
		ALLEGRO_EVENT_DISPLAY_RESIZE              = 41,
		ALLEGRO_EVENT_DISPLAY_CLOSE               = 42,
		ALLEGRO_EVENT_DISPLAY_LOST                = 43,
		ALLEGRO_EVENT_DISPLAY_FOUND               = 44,
		ALLEGRO_EVENT_DISPLAY_SWITCH_IN           = 45,
		ALLEGRO_EVENT_DISPLAY_SWITCH_OUT          = 46,
		ALLEGRO_EVENT_DISPLAY_ORIENTATION         = 47,
		ALLEGRO_EVENT_DISPLAY_HALT_DRAWING        = 48,
		ALLEGRO_EVENT_DISPLAY_RESUME_DRAWING      = 49,

		ALLEGRO_EVENT_TOUCH_BEGIN                 = 50,
		ALLEGRO_EVENT_TOUCH_END                   = 51,
		ALLEGRO_EVENT_TOUCH_MOVE                  = 52,
		ALLEGRO_EVENT_TOUCH_CANCEL                = 53,

		ALLEGRO_EVENT_DISPLAY_CONNECTED           = 60,
		ALLEGRO_EVENT_DISPLAY_DISCONNECTED        = 61
	}
}

bool ALLEGRO_EVENT_TYPE_IS_USER(ALLEGRO_EVENT_TYPE t)
{
	return t >= 512;
}

ALLEGRO_EVENT_TYPE ALLEGRO_GET_EVENT_TYPE(char a, char b, char c, char d)
{
	return AL_ID(a, b, c, d);
}

package char[] _AL_EVENT_HEADER(in char[] src_type)
{
	return "ALLEGRO_EVENT_TYPE type;" ~ src_type ~ "* source; double timestamp;";
}

nothrow @nogc extern (C)
{
	struct ALLEGRO_EVENT_SOURCE
	{
		int[32] __pad = void;
	}
	
	struct ALLEGRO_ANY_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_EVENT_SOURCE"));
	}
	
	struct ALLEGRO_DISPLAY_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_DISPLAY"));
		int x, y;
		int width, height;
		int orientation;
	}

	struct ALLEGRO_JOYSTICK_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_JOYSTICK"));
		ALLEGRO_JOYSTICK* id;
		int stick;
		int axis;
		float pos;
		int button;
	}

	struct ALLEGRO_KEYBOARD_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_KEYBOARD"));
		ALLEGRO_DISPLAY* display;  /* the window the key was pressed in */
		int keycode;               /* the physical key pressed */
		int unichar;               /* unicode character or negative */
		uint modifiers;            /* bitfield */
		bool repeat;               /* auto-repeated or not */
	}

	struct ALLEGRO_MOUSE_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_MOUSE"));
		ALLEGRO_DISPLAY* display;
		/* (display) Window the event originate from */
		/* (x, y) Primary mouse position */
		/* (z) Mouse wheel position (1D 'wheel'), or,  */
		/* (w, z) Mouse wheel position (2D 'ball') */
		int x,  y,  z, w;
		int dx, dy, dz, dw;
		uint button;
		float pressure;
	}

	struct ALLEGRO_TIMER_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_TIMER"));
		long count;
		double error;
	}
	
	struct ALLEGRO_TOUCH_EVENT
	{
	   mixin(_AL_EVENT_HEADER("ALLEGRO_TOUCH_INPUT"));
	   ALLEGRO_DISPLAY* display;
	   /* (id) Identifier of the event, always positive number.
		* (x, y) Touch position on the screen in 1:1 resolution.
		* (dx, dy) Relative touch position.
		* (primary) True, if touch is a primary one (usually first one).
		*/
	   int id;
	   float x, y;
	   float dx, dy;
	   bool primary;
	}
	
	struct ALLEGRO_USER_EVENT_DESCRIPTOR;

	struct ALLEGRO_USER_EVENT
	{
		mixin(_AL_EVENT_HEADER("ALLEGRO_EVENT_SOURCE"));
		ALLEGRO_USER_EVENT_DESCRIPTOR* __internal__descr;
		intptr_t data1;
		intptr_t data2;
		intptr_t data3;
		intptr_t data4;
	}
	
	union ALLEGRO_EVENT
	{
		/* This must be the same as the first field of _AL_EVENT_HEADER.  */
		ALLEGRO_EVENT_TYPE type;
		
		ALLEGRO_ANY_EVENT      any;
		ALLEGRO_DISPLAY_EVENT  display;
		ALLEGRO_JOYSTICK_EVENT joystick;
		ALLEGRO_KEYBOARD_EVENT keyboard;
		ALLEGRO_MOUSE_EVENT    mouse;
		ALLEGRO_TIMER_EVENT    timer;
		ALLEGRO_TOUCH_EVENT    touch;
		ALLEGRO_USER_EVENT     user;
	}
	
	/* Event sources */
	void al_init_user_event_source(ALLEGRO_EVENT_SOURCE* src);
	void al_destroy_user_event_source(ALLEGRO_EVENT_SOURCE* src);
	/* The second argument is ALLEGRO_EVENT instead of ALLEGRO_USER_EVENT
	 * to prevent users passing a pointer to a too-short structure.
	 */
	bool al_emit_user_event(ALLEGRO_EVENT_SOURCE *, ALLEGRO_EVENT *, void function(ALLEGRO_USER_EVENT *) dtor);
	void al_unref_user_event(ALLEGRO_USER_EVENT *);
	void al_set_event_source_data(ALLEGRO_EVENT_SOURCE*, intptr_t data);
	intptr_t al_get_event_source_data(in ALLEGRO_EVENT_SOURCE*);

	/* Event queues */

	struct ALLEGRO_EVENT_QUEUE;

	ALLEGRO_EVENT_QUEUE* al_create_event_queue();
	void al_destroy_event_queue(ALLEGRO_EVENT_QUEUE*);
	bool al_is_event_source_registered(ALLEGRO_EVENT_QUEUE *, ALLEGRO_EVENT_SOURCE *);
	void al_register_event_source(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
	void al_unregister_event_source(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT_SOURCE*);
	void al_pause_event_queue(ALLEGRO_EVENT_QUEUE*, bool);
	bool al_is_event_queue_paused(in ALLEGRO_EVENT_QUEUE*);
	bool al_is_event_queue_empty(ALLEGRO_EVENT_QUEUE*);
	bool al_get_next_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_peek_next_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_drop_next_event(ALLEGRO_EVENT_QUEUE*);
	void al_flush_event_queue(ALLEGRO_EVENT_QUEUE*);
	void al_wait_for_event(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event);
	bool al_wait_for_event_timed(ALLEGRO_EVENT_QUEUE*, ALLEGRO_EVENT* ret_event, float secs);
	bool al_wait_for_event_until(ALLEGRO_EVENT_QUEUE* queue, ALLEGRO_EVENT* ret_event, ALLEGRO_TIMEOUT* timeout);
}
