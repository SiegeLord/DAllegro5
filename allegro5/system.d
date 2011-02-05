module allegro5.system;

import allegro5.allegro;

version(Tango)
{
	import tango.stdc.stdlib : atexit;
}
else
{
	import std.c.stdlib : atexit;
}

extern (C)
{
	struct ALLEGRO_SYSTEM;

	bool al_install_system(int vers, int function(void function()) atexit_ptr);
	void al_uninstall_system();
	bool al_is_system_installed();
	ALLEGRO_CONFIG* al_get_system_config();

	bool al_init()
	{
		return al_install_system(ALLEGRO_VERSION_INT, &atexit);
	}

	enum 
	{
		ALLEGRO_RESOURCES_PATH = 0,
		ALLEGRO_TEMP_PATH,
		ALLEGRO_USER_DATA_PATH,
		ALLEGRO_USER_HOME_PATH,
		ALLEGRO_USER_SETTINGS_PATH,
		ALLEGRO_USER_DOCUMENTS_PATH,
		ALLEGRO_EXENAME_PATH,
		ALLEGRO_LAST_PATH // must be last
	}

	ALLEGRO_PATH* get_standard_path(int id);

	void al_set_orgname(in char* orgname);
	void al_set_appname(in char* appname);
	char* al_get_orgname();
	char* al_get_appname();

	bool al_inhibit_screensaver(bool inhibit);
}
