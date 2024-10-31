module allegro5.system;

import allegro5.internal.da5;
import allegro5.config;
import allegro5.path;
import allegro5.base;

import core.thread;
import core.stdc.stdlib : atexit;

extern (C) void rt_moduleTlsCtor();
extern (C) void rt_moduleTlsDtor();

int al_run_allegro(scope int delegate() user_main)
{
	__gshared int delegate() user_main_inner;
	user_main_inner = user_main;
	extern(C) static int main_runner(int argc, char** argv)
	{
		version(OSX)
		{
			thread_attachThis();
			rt_moduleTlsCtor();
		}

		auto main_ret = user_main_inner();

		version(OSX)
		{
			thread_detachThis();
			rt_moduleTlsDtor();
		}

		return main_ret;
	}

	return al_run_main(0, null, &main_runner);
}

nothrow @nogc extern (C)
{
	struct ALLEGRO_SYSTEM {};

	bool al_install_system(int vers, int function(void function()) atexit_ptr);
	void al_uninstall_system();
	bool al_is_system_installed();
	ALLEGRO_SYSTEM* al_get_system_driver();
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

	ALLEGRO_PATH* al_get_standard_path(int id);
	void al_set_exe_name(const(char)* path);

	void al_set_org_name(const(char)* orgname);
	void al_set_app_name(const(char)* appname);
	const(char)* al_get_org_name();
	const(char)* al_get_app_name();

	bool al_inhibit_screensaver(bool inhibit);
}
