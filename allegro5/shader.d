module allegro5.shader;

import allegro5.bitmap;
import allegro5.transformations;
import allegro5.internal.da5;

nothrow @nogc extern(C)
{
	struct ALLEGRO_SHADER {};

	enum ALLEGRO_SHADER_TYPE
	{
		ALLEGRO_VERTEX_SHADER = 1,
		ALLEGRO_PIXEL_SHADER = 2
	}

	enum ALLEGRO_SHADER_PLATFORM {
		ALLEGRO_SHADER_AUTO = 0,
		ALLEGRO_SHADER_GLSL = 1,
		ALLEGRO_SHADER_HLSL = 2
	}

	const ALLEGRO_SHADER_VAR_COLOR           = "al_color";
	const ALLEGRO_SHADER_VAR_POS             = "al_pos";
	const ALLEGRO_SHADER_VAR_PROJVIEW_MATRIX = "al_projview_matrix";
	const ALLEGRO_SHADER_VAR_TEX             = "al_tex";
	const ALLEGRO_SHADER_VAR_TEXCOORD        = "al_texcoord";
	const ALLEGRO_SHADER_VAR_TEX_MATRIX      = "al_tex_matrix";
	const ALLEGRO_SHADER_VAR_USER_ATTR       = "al_user_attr_";
	const ALLEGRO_SHADER_VAR_USE_TEX         = "al_use_tex";
	const ALLEGRO_SHADER_VAR_USE_TEX_MATRIX  = "al_use_tex_matrix";

	ALLEGRO_SHADER* al_create_shader(ALLEGRO_SHADER_PLATFORM platform);
	bool al_attach_shader_source(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const_char* source);
	bool al_attach_shader_source_file(ALLEGRO_SHADER* shader, ALLEGRO_SHADER_TYPE type, const_char* filename);
	bool al_build_shader(ALLEGRO_SHADER* shader);
	const_char* al_get_shader_log(ALLEGRO_SHADER* shader);
	ALLEGRO_SHADER_PLATFORM al_get_shader_platform(ALLEGRO_SHADER* shader);
	bool al_use_shader(ALLEGRO_SHADER* shader);
	void al_destroy_shader(ALLEGRO_SHADER* shader);

	bool al_set_shader_sampler(const_char* name, ALLEGRO_BITMAP* bitmap, int unit);
	bool al_set_shader_matrix(const_char* name, ALLEGRO_TRANSFORM* matrix);
	bool al_set_shader_int(const_char* name, int i);
	bool al_set_shader_float(const_char* name, float f);
	bool al_set_shader_int_vector(const_char* name, int num_components, int* i, int num_elems);
	bool al_set_shader_float_vector(const_char* name, int num_components, float* f, int num_elems);
	bool al_set_shader_bool(const_char* name, bool b);

	const_char* al_get_default_shader_source(ALLEGRO_SHADER_PLATFORM platform, ALLEGRO_SHADER_TYPE type);
}
