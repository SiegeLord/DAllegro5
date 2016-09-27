module allegro5.utf8;

import allegro5.internal.da5;

version (Tango)
{
	import tango.core.Vararg : va_list;
}
else
{
	version(D_Version2)
	{
		import core.stdc.stdarg : va_list;
	}
	else
	{
		import std.c.stdarg : va_list;
	}
}

nothrow @nogc extern (C)
{
	struct _al_tagbstring
	{
		int mlen;
		int slen;
		char* data;
	}
	
	alias _al_tagbstring ALLEGRO_USTR;
	alias _al_tagbstring ALLEGRO_USTR_INFO;
	
	version(D_Version2)
		mixin(`alias const(ALLEGRO_USTR) const_ALLEGRO_USTR;`);
	else
		alias ALLEGRO_USTR const_ALLEGRO_USTR;
	
	ALLEGRO_USTR* al_ustr_new(in char* s);
	ALLEGRO_USTR* al_ustr_new_from_buffer(in char* s, size_t size);
	ALLEGRO_USTR* al_ustr_newf(in char* fmt, ...);
	void al_ustr_free(ALLEGRO_USTR* us);
	const_char* al_cstr(in ALLEGRO_USTR* us);
	void al_ustr_to_buffer(in ALLEGRO_USTR* us, char* buffer, int size);
	char* al_cstr_dup(in ALLEGRO_USTR* us);
	ALLEGRO_USTR* al_ustr_dup(in ALLEGRO_USTR* us);
	ALLEGRO_USTR* al_ustr_dup_substr(in ALLEGRO_USTR* us, int start_pos, int end_pos);
	
	/* Predefined string */
	const_ALLEGRO_USTR* al_ustr_empty_string();

	/* Reference strings */
	const_ALLEGRO_USTR* al_ref_cstr(ALLEGRO_USTR_INFO* info, in char* s);
	const_ALLEGRO_USTR* al_ref_buffer(ALLEGRO_USTR_INFO* info, in char* s, size_t size);
	const_ALLEGRO_USTR* al_ref_ustr(ALLEGRO_USTR_INFO* info, in ALLEGRO_USTR* us, int start_pos, int end_pos);

	/* Sizes and offsets */
	size_t al_ustr_size(in ALLEGRO_USTR* us);
	size_t al_ustr_length(in ALLEGRO_USTR* us);
	int al_ustr_offset(in ALLEGRO_USTR* us, int index);
	bool al_ustr_next(in ALLEGRO_USTR* us, int* pos);
	bool al_ustr_prev(in ALLEGRO_USTR* us, int* pos);

	/* Get codepoints */
	int al_ustr_get(in ALLEGRO_USTR* us, int pos);
	int al_ustr_get_next(in ALLEGRO_USTR* us, int* pos);
	int al_ustr_prev_get(in ALLEGRO_USTR* us, int* pos);

	/* Insert */
	bool al_ustr_insert(ALLEGRO_USTR* us1, int pos, in ALLEGRO_USTR* us2);
	bool al_ustr_insert_cstr(ALLEGRO_USTR* us, int pos, in char* us2);
	size_t al_ustr_insert_chr(ALLEGRO_USTR* us, int pos, int c);

	/* Append */
	bool al_ustr_append(ALLEGRO_USTR* us1, in ALLEGRO_USTR* us2);
	bool al_ustr_append_cstr(ALLEGRO_USTR* us, in char* s);
	size_t al_ustr_append_chr(ALLEGRO_USTR* us, int c);
	bool al_ustr_appendf(ALLEGRO_USTR* us, in char* fmt, ...);
	bool al_ustr_vappendf(ALLEGRO_USTR* us, in char* fmt, va_list ap);

	/* Remove */
	bool al_ustr_remove_chr(ALLEGRO_USTR* us, int pos);
	bool al_ustr_remove_range(ALLEGRO_USTR* us, int start_pos, int end_pos);
	bool al_ustr_truncate(ALLEGRO_USTR* us, int start_pos);
	bool al_ustr_ltrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_rtrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_trim_ws(ALLEGRO_USTR* us);

	/* Assign */
	bool al_ustr_assign(ALLEGRO_USTR* us1, in ALLEGRO_USTR* us2);
	bool al_ustr_assign_substr(ALLEGRO_USTR* us1, in ALLEGRO_USTR* us2, int start_pos, int end_pos);
	bool al_ustr_assign_cstr(ALLEGRO_USTR* us1, in char* s);

	/* Replace */
	size_t al_ustr_set_chr(ALLEGRO_USTR* us, int pos, int c);
	bool al_ustr_replace_range(ALLEGRO_USTR* us1, int start_pos1, int end_pos1, in ALLEGRO_USTR* us2);

	/* Searching */
	int al_ustr_find_chr(in ALLEGRO_USTR* us, int start_pos, int c);
	int al_ustr_rfind_chr(in ALLEGRO_USTR* us, int start_pos, int c);
	int al_ustr_find_set(in ALLEGRO_USTR* us, int start_pos, in ALLEGRO_USTR* accept);
	int al_ustr_find_set_cstr(in ALLEGRO_USTR* us, int start_pos, in char* accept);
	int al_ustr_find_cset(in ALLEGRO_USTR* us, int start_pos, in ALLEGRO_USTR* reject);
	int al_ustr_find_cset_cstr(in ALLEGRO_USTR* us, int start_pos, in char* reject);
	int al_ustr_find_str(in ALLEGRO_USTR* haystack, int start_pos, in ALLEGRO_USTR* needle);
	int al_ustr_find_cstr(in ALLEGRO_USTR* haystack, int start_pos, in char* needle);
	int al_ustr_rfind_str(in ALLEGRO_USTR* haystack, int start_pos, in ALLEGRO_USTR* needle);
	int al_ustr_rfind_cstr(in ALLEGRO_USTR* haystack, int start_pos, in char* needle);
	bool al_ustr_find_replace(ALLEGRO_USTR* us, int start_pos, in ALLEGRO_USTR* find, in ALLEGRO_USTR* replace);
	bool al_ustr_find_replace_cstr(ALLEGRO_USTR* us, int start_pos, in char* find, in char* replace);

	/* Compare */
	bool al_ustr_equal(in ALLEGRO_USTR* us1, in ALLEGRO_USTR* us2);
	int al_ustr_compare(in ALLEGRO_USTR* u, in ALLEGRO_USTR* v);
	int al_ustr_ncompare(in ALLEGRO_USTR* us1, in ALLEGRO_USTR* us2, int n);
	bool al_ustr_has_prefix(in ALLEGRO_USTR* u, in ALLEGRO_USTR* v);
	bool al_ustr_has_prefix_cstr(in ALLEGRO_USTR* u, in char* s);
	bool al_ustr_has_suffix(in ALLEGRO_USTR* u, in ALLEGRO_USTR* v);
	bool al_ustr_has_suffix_cstr(in ALLEGRO_USTR* us1, in char* s);

	/* Low level UTF-8 functions */
	size_t al_utf8_width(int c);
	size_t al_utf8_encode(char* s, int c);

	/* UTF-16 */
	ALLEGRO_USTR* al_ustr_new_from_utf16(in ushort* s);
	size_t al_ustr_size_utf16(in ALLEGRO_USTR* us);
	size_t al_ustr_encode_utf16(in ALLEGRO_USTR* us, ushort* s, size_t n);
	size_t al_utf16_width(int c);
	size_t al_utf16_encode(ushort* s, int c);
}
