module allegro5.allegro_shader;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_shader");
}

import allegro5.allegro;
import allegro5.internal.da5;

extern (C)
{
	struct ALLEGRO_SHADER {};

	enum ALLEGRO_SHADER_TYPE
	{
	   ALLEGRO_VERTEX_SHADER = 1,
	   ALLEGRO_PIXEL_SHADER = 2
	}

	enum ALLEGRO_SHADER_PLATFORM
	{
	   ALLEGRO_SHADER_AUTO = 0,
	   ALLEGRO_SHADER_GLSL = 1,
	   ALLEGRO_SHADER_HLSL = 2,
	   ALLEGRO_SHADER_CG   = 4
	}

	ALLEGRO_SHADER* al_create_shader(ALLEGRO_SHADER_PLATFORM platform);
	bool al_attach_shader_source(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, in char* source);
	bool al_attach_shader_source_file(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, in char* filename);
	bool al_link_shader(ALLEGRO_SHADER* shader);
	const_char* al_get_shader_log(ALLEGRO_SHADER* shader);
	void al_set_shader(ALLEGRO_DISPLAY* display, ALLEGRO_SHADER* shader);
	void al_use_shader(ALLEGRO_SHADER* shader, bool use);
	void al_destroy_shader(ALLEGRO_SHADER* shader);

	bool al_set_shader_sampler(ALLEGRO_SHADER* shader, in char* name, ALLEGRO_BITMAP* bitmap, int unit);
	bool al_set_shader_matrix(ALLEGRO_SHADER* shader, in char* name, ALLEGRO_TRANSFORM* matrix);
	bool al_set_shader_int(ALLEGRO_SHADER* shader, in char* name, int i);
	bool al_set_shader_float(ALLEGRO_SHADER* shader, in char* name, float f);
	bool al_set_shader_int_vector(ALLEGRO_SHADER* shader, in char* name, int elem_size, int* i, int num_elems);
	bool al_set_shader_float_vector(ALLEGRO_SHADER* shader, in char* name, int elem_size, float* f, int num_elems);
	bool al_set_shader_bool(ALLEGRO_SHADER* shader, in char* name, bool b);

	bool al_set_shader_vertex_array(ALLEGRO_SHADER* shader, float* v, int stride);
	bool al_set_shader_color_array(ALLEGRO_SHADER* shader, ubyte* c, int stride);
	bool al_set_shader_texcoord_array(ALLEGRO_SHADER* shader, float* u, int stride);
}
