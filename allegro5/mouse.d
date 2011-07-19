module allegro5.mouse;

import allegro5.display;
import allegro5.events;
import allegro5.bitmap;

extern (C) 
{
	const int ALLEGRO_MOUSE_MAX_EXTRA_AXES = 4;

	struct ALLEGRO_MOUSE;

	struct ALLEGRO_MOUSE_STATE
	{
		int x;
		int y;
		int z;
		int w;
		int more_axes[ALLEGRO_MOUSE_MAX_EXTRA_AXES];
		int buttons;
		float pressure;
		ALLEGRO_DISPLAY* display;
	}

	struct ALLEGRO_MOUSE_CURSOR;

	enum ALLEGRO_SYSTEM_MOUSE_CURSOR
	{
		ALLEGRO_SYSTEM_MOUSE_CURSOR_NONE        =  0,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_DEFAULT     =  1,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_ARROW       =  2,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_BUSY        =  3,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_QUESTION    =  4,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_EDIT        =  5,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_MOVE        =  6,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_N    =  7,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_W    =  8,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_S    =  9,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_E    = 10,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NW   = 11,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SW   = 12,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_SE   = 13,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_RESIZE_NE   = 14,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_PROGRESS    = 15,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_PRECISION   = 16,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_LINK        = 17,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_ALT_SELECT  = 18,
		ALLEGRO_SYSTEM_MOUSE_CURSOR_UNAVAILABLE = 19,
		ALLEGRO_NUM_SYSTEM_MOUSE_CURSORS
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

	ALLEGRO_MOUSE_CURSOR* al_create_mouse_cursor(ALLEGRO_BITMAP* sprite, int xfocus, int yfocus);
	void al_destroy_mouse_cursor(ALLEGRO_MOUSE_CURSOR* cursor);
	bool al_set_mouse_cursor(ALLEGRO_DISPLAY* display, ALLEGRO_MOUSE_CURSOR* cursor);
	bool al_set_system_mouse_cursor(ALLEGRO_SYSTEM_MOUSE_CURSOR cursor_id);
	bool al_show_mouse_cursor(ALLEGRO_DISPLAY* display);
	bool al_hide_mouse_cursor(ALLEGRO_DISPLAY* display);
	bool al_get_mouse_cursor_position(int* ret_x, int* ret_y);
	bool al_grab_mouse(ALLEGRO_DISPLAY* display);
	bool al_ungrab_mouse();
}
