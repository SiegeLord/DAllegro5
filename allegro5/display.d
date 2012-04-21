module allegro5.display;

import allegro5.bitmap;
import allegro5.color;
import allegro5.events;

extern (C)
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
		ALLEGRO_USE_PROGRAMMABLE_PIPELINE   = 1 << 11
	}

	enum ALLEGRO_DISPLAY_OPTIONS
	{
		ALLEGRO_RED_SIZE,
		ALLEGRO_GREEN_SIZE,
		ALLEGRO_BLUE_SIZE,
		ALLEGRO_ALPHA_SIZE,
		ALLEGRO_RED_SHIFT,
		ALLEGRO_GREEN_SHIFT,
		ALLEGRO_BLUE_SHIFT,
		ALLEGRO_ALPHA_SHIFT,
		ALLEGRO_ACC_RED_SIZE,
		ALLEGRO_ACC_GREEN_SIZE,
		ALLEGRO_ACC_BLUE_SIZE,
		ALLEGRO_ACC_ALPHA_SIZE,
		ALLEGRO_STEREO,
		ALLEGRO_AUX_BUFFERS,
		ALLEGRO_COLOR_SIZE,
		ALLEGRO_DEPTH_SIZE,
		ALLEGRO_STENCIL_SIZE,
		ALLEGRO_SAMPLE_BUFFERS,
		ALLEGRO_SAMPLES,
		ALLEGRO_RENDER_METHOD,
		ALLEGRO_FLOAT_COLOR,
		ALLEGRO_FLOAT_DEPTH,
		ALLEGRO_SINGLE_BUFFER,
		ALLEGRO_SWAP_METHOD,
		ALLEGRO_COMPATIBLE_DISPLAY,
		ALLEGRO_UPDATE_DISPLAY_REGION,
		ALLEGRO_VSYNC,
		ALLEGRO_AUTO_CONVERT_BITMAPS,
		ALLEGRO_SUPPORTED_ORIENTATIONS,
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

	struct ALLEGRO_DISPLAY {};

	struct ALLEGRO_DISPLAY_MODE
	{
		int width;
		int height;
		int format;
		int refresh_rate;
	}

	struct ALLEGRO_MONITOR_INFO
	{
		int x1;
		int y1;
		int x2;
		int y2;
	}

	enum
	{
		ALLEGRO_DEFAULT_DISPLAY_ADAPTER = -1
	}

	void al_set_new_display_refresh_rate(int refresh_rate);
	void al_set_new_display_flags(int flags);
	int  al_get_new_display_refresh_rate();
	int  al_get_new_display_flags();

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

	int al_get_num_display_modes();
	ALLEGRO_DISPLAY_MODE* al_get_display_mode(int index, ALLEGRO_DISPLAY_MODE* mode);

	bool al_wait_for_vsync();

	ALLEGRO_EVENT_SOURCE* al_get_display_event_source(ALLEGRO_DISPLAY* display);

	/* Primitives */
	void al_clear_to_color(ALLEGRO_COLOR color);
	void al_draw_pixel(float x, float y, ALLEGRO_COLOR color);

	void al_set_display_icon(ALLEGRO_DISPLAY* display, ALLEGRO_BITMAP* icon);

	/* Stuff for multihead/window management */
	int al_get_num_video_adapters();
	bool al_get_monitor_info(int adapter, ALLEGRO_MONITOR_INFO* info);
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
	void al_change_display_option(ALLEGRO_DISPLAY* display, int option, int value);
	int al_get_display_option(ALLEGRO_DISPLAY* display, int option);
	
	/*Deferred drawing*/
	void al_hold_bitmap_drawing(bool hold);
	bool al_is_bitmap_drawing_held();
	
	void al_acknowledge_drawing_halt(ALLEGRO_DISPLAY* display);
	void al_acknowledge_drawing_resume(ALLEGRO_DISPLAY* display);
}
