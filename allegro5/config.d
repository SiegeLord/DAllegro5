module allegro5.config;

import allegro5.internal.da5;
import allegro5.file;

nothrow @nogc extern (C)
{
	struct ALLEGRO_CONFIG {};
	struct ALLEGRO_CONFIG_SECTION {};
	struct ALLEGRO_CONFIG_ENTRY {};
	
	ALLEGRO_CONFIG* al_create_config();
	void al_add_config_section(ALLEGRO_CONFIG* config, in char* name);
	void al_set_config_value(ALLEGRO_CONFIG* config, in char* section, in char* key, in char* value);
	void al_add_config_comment(ALLEGRO_CONFIG* config, in char* section, in char* comment);
	const_char* al_get_config_value(in ALLEGRO_CONFIG* config, in char* section, in char* key);
	ALLEGRO_CONFIG* al_load_config_file(in char* filename);
	ALLEGRO_CONFIG* al_load_config_file_f(ALLEGRO_FILE* filename);
	bool al_save_config_file(in char* filename, in ALLEGRO_CONFIG* config);
	bool al_save_config_file_f(ALLEGRO_FILE* file, in ALLEGRO_CONFIG* config);
	void al_merge_config_into(ALLEGRO_CONFIG* master, in ALLEGRO_CONFIG* add);
	ALLEGRO_CONFIG* al_merge_config(in ALLEGRO_CONFIG* cfg1, in ALLEGRO_CONFIG* cfg2);
	void al_destroy_config(ALLEGRO_CONFIG* config);
	bool al_remove_config_section(ALLEGRO_CONFIG* config, in char* section);
	bool al_remove_config_key(ALLEGRO_CONFIG* config, in char* section, in char* key);

	const_char* al_get_first_config_section(in ALLEGRO_CONFIG* config, ALLEGRO_CONFIG_SECTION** iterator);
	const_char* al_get_next_config_section(ALLEGRO_CONFIG_SECTION** iterator);
	const_char* al_get_first_config_entry(in ALLEGRO_CONFIG* config, in char* section, ALLEGRO_CONFIG_ENTRY** iterator);
	const_char* al_get_next_config_entry(ALLEGRO_CONFIG_ENTRY** iterator);
}
