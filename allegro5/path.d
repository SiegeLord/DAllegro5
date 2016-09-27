module allegro5.path;

import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	version(Windows)
	{
		const char ALLEGRO_NATIVE_PATH_SEP = '\\';
		const char ALLEGRO_NATIVE_DRIVE_SEP = ':';
	}
	else
	{
		const char ALLEGRO_NATIVE_PATH_SEP = '/';
		const char ALLEGRO_NATIVE_DRIVE_SEP = '\0';
	}
	
	struct ALLEGRO_PATH {};

	ALLEGRO_PATH* al_create_path(in char* str);
	ALLEGRO_PATH* al_create_path_for_directory(in char* str);
	ALLEGRO_PATH* al_clone_path(in ALLEGRO_PATH* path);

	int al_get_path_num_components(in ALLEGRO_PATH* path);
	const_char* al_get_path_component(in ALLEGRO_PATH* path, int i);
	void al_replace_path_component(ALLEGRO_PATH* path, int i, in char* s);
	void al_remove_path_component(ALLEGRO_PATH* path, int i);
	void al_insert_path_component(ALLEGRO_PATH* path, int i, in char* s);
	const_char* al_get_path_tail(in ALLEGRO_PATH* path);
	void al_drop_path_tail(ALLEGRO_PATH* path);
	void al_append_path_component(ALLEGRO_PATH* path, in char* s);
	bool al_join_paths(ALLEGRO_PATH* path, in ALLEGRO_PATH* tail);
	bool al_rebase_path(in ALLEGRO_PATH* head, ALLEGRO_PATH* tail);
	const_char* al_path_cstr(in ALLEGRO_PATH* path, char delim);
	void al_destroy_path(ALLEGRO_PATH* path);

	void al_set_path_drive(ALLEGRO_PATH* path, in char* drive);
	const_char* al_get_path_drive(in ALLEGRO_PATH* path);

	void al_set_path_filename(ALLEGRO_PATH* path, in char* filename);
	const_char* al_get_path_filename(in ALLEGRO_PATH* path);

	const_char* al_get_path_extension(in ALLEGRO_PATH* path);
	bool al_set_path_extension(ALLEGRO_PATH* path, in char* extension);
	const_char* al_get_path_basename(in ALLEGRO_PATH* path);

	bool al_make_path_canonical(ALLEGRO_PATH* path);
}
