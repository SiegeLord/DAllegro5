module allegro5.mouse;

import allegro5.display;
import allegro5.events;
import allegro5.bitmap;

nothrow @nogc extern (C)
{
	const int ALLEGRO_MOUSE_MAX_EXTRA_AXES = 4;

	struct ALLEGRO_MOUSE {};

	struct ALLEGRO_MOUSE_STATE
	{
		int x;
		int y;
		int z;
		int w;
		int[ALLEGRO_MOUSE_MAX_EXTRA_AXES] more_axes;
		int buttons;
		float pressure;
		ALLEGRO_DISPLAY* display;
	}

	bool al_is_mouse_installed();
	bool al_install_mouse();
	void al_uninstall_mouse();
	uint al_get_mouse_num_buttons();
	uint al_get_mouse_num_axes();
	bool al_set_mouse_xy        (ALLEGRO_DISPLAY* display, int x, int y);
	bool al_set_mouse_z         (int z);
	bool al_set_mouse_w         (int w);
	bool al_set_mouse_axis      (int axis, int value);
	void al_get_mouse_state     (ALLEGRO_MOUSE_STATE* ret_state);
	bool al_mouse_button_down   (in ALLEGRO_MOUSE_STATE* state, int button);
	int  al_get_mouse_state_axis(in ALLEGRO_MOUSE_STATE* state, int axis);

	ALLEGRO_EVENT_SOURCE* al_get_mouse_event_source();

	bool al_get_mouse_cursor_position(int* ret_x, int* ret_y);
	bool al_grab_mouse(ALLEGRO_DISPLAY* display);
	bool al_ungrab_mouse();
	void al_set_mouse_wheel_precision(int precision);
	int al_get_mouse_wheel_precision();
}
