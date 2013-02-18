module allegro5.allegro_shader_glsl;

import allegro5.internal.da5;

extern(C)
{
	const_char* al_get_default_glsl_vertex_shader();
	const_char* al_get_default_glsl_pixel_shader();
}
