module allegro5.allegro_native_dialog;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_dialog");
}

import allegro5.allegro;

extern (C)
{
	struct ALLEGRO_FILECHOOSER {};
	struct ALLEGRO_TEXTLOG {};

	bool al_init_native_dialog_addon();
	void al_shutdown_native_dialog_addon();

	ALLEGRO_FILECHOOSER* al_create_native_file_dialog(in ALLEGRO_PATH* initial_path, in char* title, in char* patterns, int mode);
	void al_show_native_file_dialog(ALLEGRO_DISPLAY* display, ALLEGRO_FILECHOOSER* dialog);
	int al_get_native_file_dialog_count(in ALLEGRO_FILECHOOSER* dialog);
	ALLEGRO_PATH* al_get_native_file_dialog_path(in ALLEGRO_FILECHOOSER* dialog, size_t index);
	void al_destroy_native_dialog(ALLEGRO_FILECHOOSER* dialog);
	
	int al_show_native_message_box(ALLEGRO_DISPLAY* display, in char* title, in char* heading, in char* text, in char* buttons, int flags);

	ALLEGRO_TEXTLOG* al_open_native_text_log(in char* title, int flags);
	void al_close_native_text_log(ALLEGRO_TEXTLOG* textlog);
	void al_append_native_text_log(ALLEGRO_TEXTLOG* textlog, in char* format, ...);
	ALLEGRO_EVENT_SOURCE* al_get_native_text_log_event_source(ALLEGRO_TEXTLOG* textlog);

	uint al_get_allegro_native_dialog_version();

	const int ALLEGRO_FILECHOOSER_FILE_MUST_EXIST = 1;
	const int ALLEGRO_FILECHOOSER_SAVE            = 2;
	const int ALLEGRO_FILECHOOSER_FOLDER          = 4;
	const int ALLEGRO_FILECHOOSER_PICTURES        = 8;
	const int ALLEGRO_FILECHOOSER_SHOW_HIDDEN     = 16;
	const int ALLEGRO_FILECHOOSER_MULTIPLE        = 32;

	const int ALLEGRO_MESSAGEBOX_WARN      = 1<<0;
	const int ALLEGRO_MESSAGEBOX_ERROR     = 1<<1;
	const int ALLEGRO_MESSAGEBOX_OK_CANCEL = 1<<2;
	const int ALLEGRO_MESSAGEBOX_YES_NO    = 1<<3;
	const int ALLEGRO_MESSAGEBOX_QUESTION  = 1<<4;
	
	const int ALLEGRO_TEXTLOG_NO_CLOSE            = 1<<0;
	const int ALLEGRO_TEXTLOG_MONOSPACE           = 1<<1;

	const int ALLEGRO_EVENT_NATIVE_DIALOG_CLOSE   = 600;
}
