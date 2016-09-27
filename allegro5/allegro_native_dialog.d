module allegro5.allegro_native_dialog;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_dialog");
}

version (ALLEGRO_UNSTABLE)
	version = AllegroNativeDialogUnstable;
version(ALLEGRO_INTERNAL_UNSTABLE)
	version = AllegroNativeDialogUnstable;
version(ALLEGRO_NATIVE_DIALOG_SRC)
	version = AllegroNativeDialogUnstable;

import allegro5.allegro;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	alias ALLEGRO_GTK_TOPLEVEL_INTERNAL ALLEGRO_GTK_TOPLEVEL;

	struct ALLEGRO_FILECHOOSER {};
	struct ALLEGRO_TEXTLOG {};
	struct ALLEGRO_MENU {};

	struct ALLEGRO_MENU_INFO
	{
	   const_char* caption;
	   ushort id;
	   int flags;
	   ALLEGRO_BITMAP* icon;
	}

	template ALLEGRO_MENU_SEPARATOR()
	{
		const ALLEGRO_MENU_SEPARATOR = ALLEGRO_MENU_INFO(null, -1, 0, null);
	}
	
	template ALLEGRO_START_OF_MENU(const_char[] caption, int id)
	{
		const ALLEGRO_START_OF_MENU = ALLEGRO_MENU_INFO(mixin(`"` ~ caption ~ `->\0"`), id, 0, NULL);
	}
	
	template ALLEGRO_END_OF_MENU()
	{
		const ALLEGRO_END_OF_MENU = ALLEGRO_MENU_INFO(null, 0, 0, null);
	}

	bool al_init_native_dialog_addon();
	void al_shutdown_native_dialog_addon();
	ALLEGRO_FILECHOOSER* al_create_native_file_dialog(in ALLEGRO_PATH* initial_path, in char* title, in char* patterns, int mode);
	void al_show_native_file_dialog(ALLEGRO_DISPLAY* display, ALLEGRO_FILECHOOSER* dialog);
	int al_get_native_file_dialog_count(in ALLEGRO_FILECHOOSER* dialog);
	ALLEGRO_PATH* al_get_native_file_dialog_path(in ALLEGRO_FILECHOOSER* dialog, size_t index);
	void al_destroy_native_file_dialog(ALLEGRO_FILECHOOSER* dialog);
	
	int al_show_native_message_box(ALLEGRO_DISPLAY* display, in char* title, in char* heading, in char* text, in char* buttons, int flags);

	ALLEGRO_TEXTLOG* al_open_native_text_log(in char* title, int flags);
	void al_close_native_text_log(ALLEGRO_TEXTLOG* textlog);
	void al_append_native_text_log(ALLEGRO_TEXTLOG* textlog, in char* format, ...);
	ALLEGRO_EVENT_SOURCE* al_get_native_text_log_event_source(ALLEGRO_TEXTLOG* textlog);
	
	/* creating/modifying menus */
	ALLEGRO_MENU* al_create_menu();;
	ALLEGRO_MENU* al_create_popup_menu();;
	ALLEGRO_MENU* al_build_menu(ALLEGRO_MENU_INFO* info);
	int al_append_menu_item(ALLEGRO_MENU* parent, in char* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
	int al_insert_menu_item(ALLEGRO_MENU* parent, int pos, in char* title, ushort id, int flags, ALLEGRO_BITMAP* icon, ALLEGRO_MENU* submenu);
	bool al_remove_menu_item(ALLEGRO_MENU* menu, int pos);
	ALLEGRO_MENU* al_clone_menu(ALLEGRO_MENU* menu);
	ALLEGRO_MENU* al_clone_menu_for_popup(ALLEGRO_MENU* menu);
	void al_destroy_menu(ALLEGRO_MENU* menu);

	/* properties */
	const_char* al_get_menu_item_caption(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_caption(ALLEGRO_MENU* menu, int pos, in char* caption);
	int al_get_menu_item_flags(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags);
	version (AllegroNativeDialogUnstable)
	{
		int al_toggle_menu_item_flags(ALLEGRO_MENU* menu, int pos, int flags);
	}
	ALLEGRO_BITMAP* al_get_menu_item_icon(ALLEGRO_MENU* menu, int pos);
	void al_set_menu_item_icon(ALLEGRO_MENU* menu, int pos, ALLEGRO_BITMAP* icon);
	 
	/* querying menus */
	ALLEGRO_MENU* al_find_menu(ALLEGRO_MENU* haystack, ushort id);
	bool al_find_menu_item(ALLEGRO_MENU* haystack, ushort id, ALLEGRO_MENU** menu, int* index);
	 
	/* menu events */
	ALLEGRO_EVENT_SOURCE* al_get_default_menu_event_source();;
	ALLEGRO_EVENT_SOURCE* al_enable_menu_event_source(ALLEGRO_MENU* menu);
	void al_disable_menu_event_source(ALLEGRO_MENU* menu);
	 
	/* displaying menus */
	ALLEGRO_MENU* al_get_display_menu(ALLEGRO_DISPLAY* display);
	bool al_set_display_menu(ALLEGRO_DISPLAY* display, ALLEGRO_MENU* menu);
	bool al_popup_menu(ALLEGRO_MENU* popup, ALLEGRO_DISPLAY* display);
	ALLEGRO_MENU* al_remove_display_menu(ALLEGRO_DISPLAY* display);

	uint al_get_allegro_native_dialog_version();

	enum
	{
		ALLEGRO_FILECHOOSER_FILE_MUST_EXIST = 1,
		ALLEGRO_FILECHOOSER_SAVE            = 2,
		ALLEGRO_FILECHOOSER_FOLDER          = 4,
		ALLEGRO_FILECHOOSER_PICTURES        = 8,
		ALLEGRO_FILECHOOSER_SHOW_HIDDEN     = 16,
		ALLEGRO_FILECHOOSER_MULTIPLE        = 32
	}

	enum
	{
		ALLEGRO_MESSAGEBOX_WARN      = 1<<0,
		ALLEGRO_MESSAGEBOX_ERROR     = 1<<1,
		ALLEGRO_MESSAGEBOX_OK_CANCEL = 1<<2,
		ALLEGRO_MESSAGEBOX_YES_NO    = 1<<3,
		ALLEGRO_MESSAGEBOX_QUESTION  = 1<<4
	}
	
	enum
	{
		ALLEGRO_TEXTLOG_NO_CLOSE            = 1<<0,
		ALLEGRO_TEXTLOG_MONOSPACE           = 1<<1
	}

	enum
	{
		ALLEGRO_EVENT_NATIVE_DIALOG_CLOSE   = 600,
		ALLEGRO_EVENT_MENU_CLICK            = 601
	}

	enum
	{
		ALLEGRO_MENU_ITEM_ENABLED            = 0,
		ALLEGRO_MENU_ITEM_CHECKBOX           = 1,
		ALLEGRO_MENU_ITEM_CHECKED            = 2,
		ALLEGRO_MENU_ITEM_DISABLED           = 4
	}
}
