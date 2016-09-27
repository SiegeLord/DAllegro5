module allegro5.display;

import allegro5.bitmap;
import allegro5.color;
import allegro5.events;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	enum
	{
		ALLEGRO_WINDOWED                    = 1 << 0,
		ALLEGRO_FULLSCREEN                  = 1 << 1,
		ALLEGRO_OPENGL                      = 1 << 2,
		ALLEGRO_DIRECT3D_INTERNAL           = 1 << 3,
		ALLEGRO_RESIZABLE                   = 1 << 4,
		ALLEGRO_FRAMELESS                   = 1 << 5,
		ALLEGRO_NOFRAME                     = ALLEGRO_FRAMELESS, /* older synonym */
		ALLEGRO_GENERATE_EXPOSE_EVENTS      = 1 << 6,
		ALLEGRO_OPENGL_3_0                  = 1 << 7,
		ALLEGRO_OPENGL_FORWARD_COMPATIBLE   = 1 << 8,
		ALLEGRO_FULLSCREEN_WINDOW           = 1 << 9,
		ALLEGRO_MINIMIZED                   = 1 << 10,
		ALLEGRO_PROGRAMMABLE_PIPELINE       = 1 << 11,
		ALLEGRO_GTK_TOPLEVEL_INTERNAL       = 1 << 12,
		ALLEGRO_MAXIMIZED                   = 1 << 13,
		ALLEGRO_OPENGL_ES_PROFILE           = 1 << 14,
	}

	enum ALLEGRO_DISPLAY_OPTIONS
	{
		ALLEGRO_RED_SIZE = 0,
		ALLEGRO_GREEN_SIZE = 1,
		ALLEGRO_BLUE_SIZE = 2,
		ALLEGRO_ALPHA_SIZE = 3,
		ALLEGRO_RED_SHIFT = 4,
		ALLEGRO_GREEN_SHIFT = 5,
		ALLEGRO_BLUE_SHIFT = 6,
		ALLEGRO_ALPHA_SHIFT = 7,
		ALLEGRO_ACC_RED_SIZE = 8,
		ALLEGRO_ACC_GREEN_SIZE = 9,
		ALLEGRO_ACC_BLUE_SIZE = 10,
		ALLEGRO_ACC_ALPHA_SIZE = 11,
		ALLEGRO_STEREO = 12,
		ALLEGRO_AUX_BUFFERS = 13,
		ALLEGRO_COLOR_SIZE = 14,
		ALLEGRO_DEPTH_SIZE = 15,
		ALLEGRO_STENCIL_SIZE = 16,
		ALLEGRO_SAMPLE_BUFFERS = 17,
		ALLEGRO_SAMPLES = 18,
		ALLEGRO_RENDER_METHOD = 19,
		ALLEGRO_FLOAT_COLOR = 20,
		ALLEGRO_FLOAT_DEPTH = 21,
		ALLEGRO_SINGLE_BUFFER = 22,
		ALLEGRO_SWAP_METHOD = 23,
		ALLEGRO_COMPATIBLE_DISPLAY = 24,
		ALLEGRO_UPDATE_DISPLAY_REGION = 25,
		ALLEGRO_VSYNC = 26,
		ALLEGRO_MAX_BITMAP_SIZE = 27,
		ALLEGRO_SUPPORT_NPOT_BITMAP = 28,
		ALLEGRO_CAN_DRAW_INTO_BITMAP = 29,
		ALLEGRO_SUPPORT_SEPARATE_ALPHA = 30,
		ALLEGRO_AUTO_CONVERT_BITMAPS = 31,
		ALLEGRO_SUPPORTED_ORIENTATIONS = 32,
		ALLEGRO_OPENGL_MAJOR_VERSION = 33,
		ALLEGRO_OPENGL_MINOR_VERSION = 34,
		ALLEGRO_DISPLAY_OPTIONS_COUNT
	}

	enum
	{
		ALLEGRO_DONTCARE,
		ALLEGRO_REQUIRE,
		ALLEGRO_SUGGEST
	}
	
	enum ALLEGRO_DISPLAY_ORIENTATION
	{
		ALLEGRO_DISPLAY_ORIENTATION_UNKNOWN = 0,
		ALLEGRO_DISPLAY_ORIENTATION_0_DEGREES = 1,
		ALLEGRO_DISPLAY_ORIENTATION_90_DEGREES = 2,
		ALLEGRO_DISPLAY_ORIENTATION_180_DEGREES = 4,
		ALLEGRO_DISPLAY_ORIENTATION_270_DEGREES = 8,
		ALLEGRO_DISPLAY_ORIENTATION_PORTRAIT = 5,
		ALLEGRO_DISPLAY_ORIENTATION_LANDSCAPE = 10,
		ALLEGRO_DISPLAY_ORIENTATION_ALL = 15,
		ALLEGRO_DISPLAY_ORIENTATION_FACE_UP = 16,
		ALLEGRO_DISPLAY_ORIENTATION_FACE_DOWN = 32
	}

	enum
	{
		_ALLEGRO_PRIM_MAX_USER_ATTR = 10
	}

	struct ALLEGRO_DISPLAY {};

	enum ALLEGRO_NEW_WINDOW_TITLE_MAX_SIZE = 255;

	void al_set_new_display_refresh_rate(int refresh_rate);
	void al_set_new_display_flags(int flags);
	int  al_get_new_display_refresh_rate();
	int  al_get_new_display_flags();

	void al_set_new_window_title(const_char *title);
	const_char* al_get_new_window_title();

	int al_get_display_width(ALLEGRO_DISPLAY* display);
	int al_get_display_height(ALLEGRO_DISPLAY* display);
	int al_get_display_format(ALLEGRO_DISPLAY* display);
	int al_get_display_refresh_rate(ALLEGRO_DISPLAY* display);
	int al_get_display_flags(ALLEGRO_DISPLAY* display);
	int al_get_display_orientation(ALLEGRO_DISPLAY* display);
	bool al_set_display_flag(ALLEGRO_DISPLAY* display, int flag, bool onoff);

	ALLEGRO_DISPLAY* al_create_display(int w, int h);
	void al_destroy_display(ALLEGRO_DISPLAY* display);
	ALLEGRO_DISPLAY* al_get_current_display();
	void al_set_target_bitmap(ALLEGRO_BITMAP* bitmap);
	void al_set_target_backbuffer(ALLEGRO_DISPLAY* display);
	ALLEGRO_BITMAP* al_get_backbuffer(ALLEGRO_DISPLAY* display);
	ALLEGRO_BITMAP* al_get_target_bitmap();

	bool al_acknowledge_resize(ALLEGRO_DISPLAY* display);
	bool al_resize_display(ALLEGRO_DISPLAY* display, int width, int height);
	void al_flip_display();
	void al_update_display_region(int x, int y, int width, int height);
	bool al_is_compatible_bitmap(ALLEGRO_BITMAP* bitmap);

	bool al_wait_for_vsync();

	ALLEGRO_EVENT_SOURCE* al_get_display_event_source(ALLEGRO_DISPLAY* display);

	void al_set_display_icon(ALLEGRO_DISPLAY* display, ALLEGRO_BITMAP* icon);
	void al_set_display_icons(ALLEGRO_DISPLAY* display, int num_icons, ALLEGRO_BITMAP** icons);

	/* Stuff for multihead/window management */
	int al_get_new_display_adapter();
	void al_set_new_display_adapter(int adapter);
	void al_set_new_window_position(int x, int y);
	void al_get_new_window_position(int* x, int* y);
	void al_set_window_position(ALLEGRO_DISPLAY* display, int x, int y);
	void al_get_window_position(ALLEGRO_DISPLAY* display, int* x, int* y);
	bool al_set_window_constraints(ALLEGRO_DISPLAY* display, int min_w, int min_h, int max_w, int max_h);
	bool al_get_window_constraints(ALLEGRO_DISPLAY* display, int* min_w, int* min_h, int* max_w, int* max_h);

	void al_set_window_title(ALLEGRO_DISPLAY* display, in char* title);

	/* Defined in display_settings.c */
	void al_set_new_display_option(int option, int value, int importance);
	int al_get_new_display_option(int option, int* importance);
	void al_reset_new_display_options();
	void al_set_display_option(ALLEGRO_DISPLAY* display, int option, int value);
	int al_get_display_option(ALLEGRO_DISPLAY* display, int option);
	
	/*Deferred drawing*/
	void al_hold_bitmap_drawing(bool hold);
	bool al_is_bitmap_drawing_held();
	
	void al_acknowledge_drawing_halt(ALLEGRO_DISPLAY* display);
	void al_acknowledge_drawing_resume(ALLEGRO_DISPLAY *display);
}
