module allegro5.joystick;

import allegro5.events;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	private const int  _AL_MAX_JOYSTICK_AXES = 3;
	private const int  _AL_MAX_JOYSTICK_STICKS = 16;
	private const int  _AL_MAX_JOYSTICK_BUTTONS = 32;
	
	struct ALLEGRO_JOYSTICK {};

	struct ALLEGRO_JOYSTICK_STATE
	{
		struct STICK
		{
			float[_AL_MAX_JOYSTICK_AXES] axis;        /* -1.0 to 1.0 */
		};
		STICK[_AL_MAX_JOYSTICK_STICKS] stick;
		int[_AL_MAX_JOYSTICK_BUTTONS] button;        /* 0 to 32767 */
	};

	enum ALLEGRO_JOYFLAGS
	{
		ALLEGRO_JOYFLAG_DIGITAL  = 0x01,
		ALLEGRO_JOYFLAG_ANALOGUE = 0x02
	}



	bool              al_install_joystick();
	void              al_uninstall_joystick();
	bool              al_is_joystick_installed();
	bool              al_reconfigure_joysticks();

	int               al_get_num_joysticks();
	ALLEGRO_JOYSTICK* al_get_joystick(int joyn);
	void              al_release_joystick(ALLEGRO_JOYSTICK* joystick);
	bool              al_get_joystick_active(ALLEGRO_JOYSTICK* joystick);
	const_char*       al_get_joystick_name(ALLEGRO_JOYSTICK* joystick);

	int               al_get_joystick_num_sticks(in ALLEGRO_JOYSTICK* joystick);
	int               al_get_joystick_stick_flags(in ALLEGRO_JOYSTICK* joystick, int stick); /* junk? */
	const_char*       al_get_joystick_stick_name(in ALLEGRO_JOYSTICK* joystick, int stick);

	int               al_get_joystick_num_axes(in ALLEGRO_JOYSTICK* joystick, int stick);
	const_char*       al_get_joystick_axis_name(in ALLEGRO_JOYSTICK* joystick, int stick, int axis);

	int               al_get_joystick_num_buttons(in ALLEGRO_JOYSTICK* joystick);
	const_char*       al_get_joystick_button_name(in ALLEGRO_JOYSTICK* joystick, int buttonn);

	void              al_get_joystick_state(ALLEGRO_JOYSTICK* joystick, ALLEGRO_JOYSTICK_STATE* ret_state);

	ALLEGRO_EVENT_SOURCE* al_get_joystick_event_source();
}

