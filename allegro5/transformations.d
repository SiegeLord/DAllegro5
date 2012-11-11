module allegro5.transformations;

extern (C)
{
	struct ALLEGRO_TRANSFORM
	{
		float[4][4] m;
	}
	
	version(D_Version2)
		mixin(`alias const(ALLEGRO_TRANSFORM) const_ALLEGRO_TRANSFORM;`);
	else
		alias ALLEGRO_TRANSFORM const_ALLEGRO_TRANSFORM;

	/* Transformations*/
	void al_use_transform(in ALLEGRO_TRANSFORM* trans);
	void al_copy_transform(in ALLEGRO_TRANSFORM* src, ALLEGRO_TRANSFORM* dest);
	void al_identity_transform(ALLEGRO_TRANSFORM* trans);
	void al_build_transform(ALLEGRO_TRANSFORM* trans, float x, float y, float sx, float sy, float theta);
	void al_translate_transform(ALLEGRO_TRANSFORM* trans, float x, float y);
	void al_rotate_transform(ALLEGRO_TRANSFORM* trans, float theta);
	void al_scale_transform(ALLEGRO_TRANSFORM* trans, float sx, float sy);
	void al_transform_coordinates(in ALLEGRO_TRANSFORM* trans, float* x, float* y);
	void al_compose_transform(ALLEGRO_TRANSFORM* trans, in ALLEGRO_TRANSFORM* trans2);
	ALLEGRO_TRANSFORM* al_get_current_transform();
	void al_invert_transform(ALLEGRO_TRANSFORM* trans);
	int  al_check_inverse(in ALLEGRO_TRANSFORM* trans, float tol);
}
