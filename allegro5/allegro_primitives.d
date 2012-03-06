module allegro5.allegro_primitives;

version(ALLEGRO_NO_PRAGMA_LIB) {}
else
{
	pragma(lib, "allegro_primitives");
}

version (Tango) {
   import tango.stdc.stdint;
}
else {
   import std.stdint;
}

import allegro5.allegro;

extern (C)
{
	enum ALLEGRO_PRIM_TYPE
	{
		ALLEGRO_PRIM_LINE_LIST,
		ALLEGRO_PRIM_LINE_STRIP,
		ALLEGRO_PRIM_LINE_LOOP,
		ALLEGRO_PRIM_TRIANGLE_LIST,
		ALLEGRO_PRIM_TRIANGLE_STRIP,
		ALLEGRO_PRIM_TRIANGLE_FAN,
		ALLEGRO_PRIM_POINT_LIST,
		ALLEGRO_PRIM_NUM_TYPES
	}

	enum ALLEGRO_PRIM_ATTR
	{
		ALLEGRO_PRIM_POSITION = 1,
		ALLEGRO_PRIM_COLOR_ATTR,
		ALLEGRO_PRIM_TEX_COORD,
		ALLEGRO_PRIM_TEX_COORD_PIXEL,
		ALLEGRO_PRIM_ATTR_NUM
	}

	enum ALLEGRO_PRIM_STORAGE
	{
		ALLEGRO_PRIM_FLOAT_2,
		ALLEGRO_PRIM_FLOAT_3,
		ALLEGRO_PRIM_SHORT_2,
	}

	const int ALLEGRO_VERTEX_CACHE_SIZE = 256;

	const int ALLEGRO_PRIM_QUALITY = 10;

	struct ALLEGRO_VERTEX_ELEMENT 
	{
		int attribute;
		int storage;
		int offset;
	}

	struct ALLEGRO_VERTEX_DECL {};

	struct ALLEGRO_VERTEX
	{
		float x, y, z;
		float u, v;
		ALLEGRO_COLOR color;
	}

	uint al_get_allegro_primitives_version();

	/*
	* Primary Functions
	*/
	bool al_init_primitives_addon();
	void al_shutdown_primitives_addon();
	int al_draw_prim(in void* vtxs, in ALLEGRO_VERTEX_DECL* decl, ALLEGRO_BITMAP* texture, int start, int end, int type);
	int al_draw_indexed_prim(in void* vtxs, in ALLEGRO_VERTEX_DECL* decl, ALLEGRO_BITMAP* texture, in int* indices, int num_vtx, int type);

	ALLEGRO_VERTEX_DECL* al_create_vertex_decl(in ALLEGRO_VERTEX_ELEMENT* elements, int stride);
	void al_destroy_vertex_decl(ALLEGRO_VERTEX_DECL* decl);

	/*
	* Custom primitives
	*/
	void al_draw_soft_triangle(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, ALLEGRO_VERTEX* v3, uintptr_t state,
	                                           void function(uintptr_t, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) init,
	                                           void function(uintptr_t, int, int, int, int) first,
	                                           void function(uintptr_t, int) step, 
	                                           void function(uintptr_t, int, int, int) draw);
	void al_draw_soft_line(ALLEGRO_VERTEX* v1, ALLEGRO_VERTEX* v2, uintptr_t state,
	                                           void function(uintptr_t, int, int, ALLEGRO_VERTEX*, ALLEGRO_VERTEX*) first,
	                                           void function(uintptr_t, int) step, 
	                                           void function(uintptr_t, int, int) draw);

	/*
	*High level primitives
	*/
	void al_draw_line(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
	void al_draw_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color, float thickness);
	void al_draw_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color, float thickness);
	void al_draw_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color, float thickness);

	void al_calculate_arc(float* dest, int stride, float cx, float cy, float rx, float ry, float start_theta, float delta_theta, float thickness, int num_segments);
	void al_draw_circle(float cx, float cy, float r, ALLEGRO_COLOR color, float thickness);
	void al_draw_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color, float thickness);
	void al_draw_arc(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
	void al_draw_elliptical_arc(float cx, float cy, float rx, float ry, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);
	void al_draw_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color, float thickness);

	void al_calculate_spline(float* dest, int stride, float points[8], float thickness, int num_segments);
	void al_draw_spline(float points[8], ALLEGRO_COLOR color, float thickness);

	void al_calculate_ribbon(float* dest, int dest_stride, in float *points, int points_stride, float thickness, int num_segments);
	void al_draw_ribbon(in float *points, int points_stride, ALLEGRO_COLOR color, float thickness, int num_segments);

	void al_draw_filled_triangle(float x1, float y1, float x2, float y2, float x3, float y3, ALLEGRO_COLOR color);
	void al_draw_filled_rectangle(float x1, float y1, float x2, float y2, ALLEGRO_COLOR color);
	void al_draw_filled_ellipse(float cx, float cy, float rx, float ry, ALLEGRO_COLOR color);
	void al_draw_filled_circle(float cx, float cy, float r, ALLEGRO_COLOR color);
	void al_draw_filled_pieslice(float cx, float cy, float r, float start_theta, float delta_theta, ALLEGRO_COLOR color);
	void al_draw_filled_rounded_rectangle(float x1, float y1, float x2, float y2, float rx, float ry, ALLEGRO_COLOR color);
}
