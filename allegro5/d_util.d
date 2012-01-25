module allegro5.d_util;

import allegro5.allegro;
import allegro5.internal.da5;

const_ALLEGRO_USTR* dstr_to_ustr(ALLEGRO_USTR_INFO* info, const_char[] dstr)
{
	return al_ref_buffer(info, dstr.ptr, dstr.length);
}

const_char[] ustr_to_dstr(const_ALLEGRO_USTR* ustr)
{
	return al_cstr(ustr)[0..al_ustr_size(ustr)];
}
