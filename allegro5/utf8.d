module allegro5.utf8;

import allegro5.internal.da5;

import core.stdc.stdarg : va_list;

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

	ALLEGRO_USTR* al_ustr_new(const(char)* s);
	ALLEGRO_USTR* al_ustr_new_from_buffer(const(char)* s, size_t size);
	ALLEGRO_USTR* al_ustr_newf(const(char)* fmt, ...);
	void al_ustr_free(ALLEGRO_USTR* us);
	const(char)* al_cstr(const(ALLEGRO_USTR)* us);
	void al_ustr_to_buffer(const(ALLEGRO_USTR)* us, char* buffer, int size);
	char* al_cstr_dup(const(ALLEGRO_USTR)* us);
	ALLEGRO_USTR* al_ustr_dup(const(ALLEGRO_USTR)* us);
	ALLEGRO_USTR* al_ustr_dup_substr(const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

	/* Predefined string */
	const(ALLEGRO_USTR)* al_ustr_empty_string();

	/* Reference strings */
	const(ALLEGRO_USTR)* al_ref_cstr(ALLEGRO_USTR_INFO* info, const(char)* s);
	const(ALLEGRO_USTR)* al_ref_buffer(ALLEGRO_USTR_INFO* info, const(char)* s, size_t size);
	const(ALLEGRO_USTR)* al_ref_ustr(ALLEGRO_USTR_INFO* info, const(ALLEGRO_USTR)* us, int start_pos, int end_pos);

	/* Sizes and offsets */
	size_t al_ustr_size(const(ALLEGRO_USTR)* us);
	size_t al_ustr_length(const(ALLEGRO_USTR)* us);
	int al_ustr_offset(const(ALLEGRO_USTR)* us, int index);
	bool al_ustr_next(const(ALLEGRO_USTR)* us, int* pos);
	bool al_ustr_prev(const(ALLEGRO_USTR)* us, int* pos);

	/* Get codepoints */
	int al_ustr_get(const(ALLEGRO_USTR)* us, int pos);
	int al_ustr_get_next(const(ALLEGRO_USTR)* us, int* pos);
	int al_ustr_prev_get(const(ALLEGRO_USTR)* us, int* pos);

	/* Insert */
	bool al_ustr_insert(ALLEGRO_USTR* us1, int pos, const(ALLEGRO_USTR)* us2);
	bool al_ustr_insert_cstr(ALLEGRO_USTR* us, int pos, const(char)* us2);
	size_t al_ustr_insert_chr(ALLEGRO_USTR* us, int pos, int c);

	/* Append */
	bool al_ustr_append(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
	bool al_ustr_append_cstr(ALLEGRO_USTR* us, const(char)* s);
	size_t al_ustr_append_chr(ALLEGRO_USTR* us, int c);
	bool al_ustr_appendf(ALLEGRO_USTR* us, const(char)* fmt, ...);
	bool al_ustr_vappendf(ALLEGRO_USTR* us, const(char)* fmt, va_list ap);

	/* Remove */
	bool al_ustr_remove_chr(ALLEGRO_USTR* us, int pos);
	bool al_ustr_remove_range(ALLEGRO_USTR* us, int start_pos, int end_pos);
	bool al_ustr_truncate(ALLEGRO_USTR* us, int start_pos);
	bool al_ustr_ltrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_rtrim_ws(ALLEGRO_USTR* us);
	bool al_ustr_trim_ws(ALLEGRO_USTR* us);

	/* Assign */
	bool al_ustr_assign(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2);
	bool al_ustr_assign_substr(ALLEGRO_USTR* us1, const(ALLEGRO_USTR)* us2, int start_pos, int end_pos);
	bool al_ustr_assign_cstr(ALLEGRO_USTR* us1, const(char)* s);

	/* Replace */
	size_t al_ustr_set_chr(ALLEGRO_USTR* us, int pos, int c);
	bool al_ustr_replace_range(ALLEGRO_USTR* us1, int start_pos1, int end_pos1, const(ALLEGRO_USTR)* us2);

	/* Searching */
	int al_ustr_find_chr(const(ALLEGRO_USTR)* us, int start_pos, int c);
	int al_ustr_rfind_chr(const(ALLEGRO_USTR)* us, int start_pos, int c);
	int al_ustr_find_set(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* accept);
	int al_ustr_find_set_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* accept);
	int al_ustr_find_cset(const(ALLEGRO_USTR)* us, int start_pos, const(ALLEGRO_USTR)* reject);
	int al_ustr_find_cset_cstr(const(ALLEGRO_USTR)* us, int start_pos, const(char)* reject);
	int al_ustr_find_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
	int al_ustr_find_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
	int al_ustr_rfind_str(const(ALLEGRO_USTR)* haystack, int start_pos, const(ALLEGRO_USTR)* needle);
	int al_ustr_rfind_cstr(const(ALLEGRO_USTR)* haystack, int start_pos, const(char)* needle);
	bool al_ustr_find_replace(ALLEGRO_USTR* us, int start_pos, const(ALLEGRO_USTR)* find, const(ALLEGRO_USTR)* replace);
	bool al_ustr_find_replace_cstr(ALLEGRO_USTR* us, int start_pos, const(char)* find, const(char)* replace);

	/* Compare */
	bool al_ustr_equal(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2);
	int al_ustr_compare(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	int al_ustr_ncompare(const(ALLEGRO_USTR)* us1, const(ALLEGRO_USTR)* us2, int n);
	bool al_ustr_has_prefix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	bool al_ustr_has_prefix_cstr(const(ALLEGRO_USTR)* u, const(char)* s);
	bool al_ustr_has_suffix(const(ALLEGRO_USTR)* u, const(ALLEGRO_USTR)* v);
	bool al_ustr_has_suffix_cstr(const(ALLEGRO_USTR)* us1, const(char)* s);

	/* Low level UTF-8 functions */
	size_t al_utf8_width(int c);
	size_t al_utf8_encode(char* s, int c);

	/* UTF-16 */
	ALLEGRO_USTR* al_ustr_new_from_utf16(const(ushort)* s);
	size_t al_ustr_size_utf16(const(ALLEGRO_USTR)* us);
	size_t al_ustr_encode_utf16(const(ALLEGRO_USTR)* us, ushort* s, size_t n);
	size_t al_utf16_width(int c);
	size_t al_utf16_encode(ushort* s, int c);
}
