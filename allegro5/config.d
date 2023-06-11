module allegro5.config;

import allegro5.internal.da5;
import allegro5.file;

nothrow @nogc extern (C)
{
	struct ALLEGRO_CONFIG {};
	struct ALLEGRO_CONFIG_SECTION {};
	struct ALLEGRO_CONFIG_ENTRY {};

	ALLEGRO_CONFIG* al_create_config();
	void al_add_config_section(ALLEGRO_CONFIG* config, const(char)* name);
	void al_set_config_value(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key, const(char)* value);
	void al_add_config_comment(ALLEGRO_CONFIG* config, const(char)* section, const(char)* comment);
	const(char)* al_get_config_value(const(ALLEGRO_CONFIG)* config, const(char)* section, const(char)* key);
	ALLEGRO_CONFIG* al_load_config_file(const(char)* filename);
	ALLEGRO_CONFIG* al_load_config_file_f(ALLEGRO_FILE* filename);
	bool al_save_config_file(const(char)* filename, const(ALLEGRO_CONFIG)* config);
	bool al_save_config_file_f(ALLEGRO_FILE* file, const(ALLEGRO_CONFIG)* config);
	void al_merge_config_into(ALLEGRO_CONFIG* master, const(ALLEGRO_CONFIG)* add);
	ALLEGRO_CONFIG* al_merge_config(const(ALLEGRO_CONFIG)* cfg1, const(ALLEGRO_CONFIG)* cfg2);
	void al_destroy_config(ALLEGRO_CONFIG* config);
	bool al_remove_config_section(ALLEGRO_CONFIG* config, const(char)* section);
	bool al_remove_config_key(ALLEGRO_CONFIG* config, const(char)* section, const(char)* key);

	const(char)* al_get_first_config_section(const(ALLEGRO_CONFIG)* config, ALLEGRO_CONFIG_SECTION** iterator);
	const(char)* al_get_next_config_section(ALLEGRO_CONFIG_SECTION** iterator);
	const(char)* al_get_first_config_entry(const(ALLEGRO_CONFIG)* config, const(char)* section, ALLEGRO_CONFIG_ENTRY** iterator);
	const(char)* al_get_next_config_entry(ALLEGRO_CONFIG_ENTRY** iterator);
}
