module allegro5.timer;

import allegro5.events;
import allegro5.internal.da5;

nothrow @nogc extern (C)
{
	struct ALLEGRO_TIMER {};

	ALLEGRO_TIMER* al_create_timer(double speed_secs);
	void al_destroy_timer(ALLEGRO_TIMER* timer);
	void al_start_timer(ALLEGRO_TIMER* timer);
	void al_stop_timer(ALLEGRO_TIMER* timer);
	void al_resume_timer(ALLEGRO_TIMER* timer);
	bool al_get_timer_started(in ALLEGRO_TIMER* timer);
	double al_get_timer_speed(in ALLEGRO_TIMER* timer);
	void al_set_timer_speed(ALLEGRO_TIMER* timer, double speed_secs);
	long al_get_timer_count(in ALLEGRO_TIMER* timer);
	void al_set_timer_count(ALLEGRO_TIMER* timer, long count);
	void al_add_timer_count(ALLEGRO_TIMER *timer, long diff);
	ALLEGRO_EVENT_SOURCE* al_get_timer_event_source(ALLEGRO_TIMER* timer);
}

double ALLEGRO_USECS_TO_SECS(double x)
{
	return x / 1000000.0;
}

double ALLEGRO_MSECS_TO_SECS(double x)
{
	return x / 1000.0;
}

double ALLEGRO_BPS_TO_SECS(double x)
{
	return 1.0 / x;
}

double ALLEGRO_BPM_TO_SECS(double x)
{
	return 60.0 / x;
}
