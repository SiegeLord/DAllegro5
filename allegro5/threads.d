module allegro5.threads;

import allegro5.allegro;

nothrow @nogc extern (C)
{
	struct ALLEGRO_THREAD {};
	struct ALLEGRO_MUTEX {};
	struct ALLEGRO_COND {};

	ALLEGRO_THREAD* al_create_thread(void *function(ALLEGRO_THREAD* thread, void* arg) proc, void* arg);
	void al_start_thread(ALLEGRO_THREAD* outer);
	void al_join_thread(ALLEGRO_THREAD* outer, void **ret_value);
	void al_set_thread_should_stop(ALLEGRO_THREAD* outer);
	bool al_get_thread_should_stop(ALLEGRO_THREAD* outer);
	void al_destroy_thread(ALLEGRO_THREAD* thread);
	void al_run_detached_thread(void *function(void* arg) proc, void* arg);

	ALLEGRO_MUTEX* al_create_mutex();
	ALLEGRO_MUTEX* al_create_mutex_recursive();
	void al_lock_mutex(ALLEGRO_MUTEX* mutex);
	void al_unlock_mutex(ALLEGRO_MUTEX* mutex);
	void al_destroy_mutex(ALLEGRO_MUTEX* mutex);

	ALLEGRO_COND* al_create_cond();
	void al_destroy_cond(ALLEGRO_COND* cond);
	void al_wait_cond(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex);
	int al_wait_cond_until(ALLEGRO_COND* cond, ALLEGRO_MUTEX* mutex, in ALLEGRO_TIMEOUT* timeout);
	void al_broadcast_cond(ALLEGRO_COND* cond);
	void al_signal_cond(ALLEGRO_COND* cond);
}
