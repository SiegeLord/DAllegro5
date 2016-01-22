/* A test of pausing/resuming a timer.
 *
 * 1. Create two 5s long timers.
 * 2. Let each run for 2s, then stop each for 2s.
 * 3. Call al_resume_timer on timer1 and al_start_timer on timer2
 * 4. Wait for timer events
 *
 * timer1 should finish before timer2, as it was resumed rather than restarted.
 *
 * Ported from the core Allegro5 library example ex_timer_pause.c.
 */
import allegro5.allegro;
import std.stdio;

import common;

pragma(lib, "dallegro5");
pragma(lib, "allegro");

/* Run our test. */
int main()
{
   const double duration = 5;  // timer lasts for 5 seconds
   const double pre_pause = 2; // how long to wait before pausing
   const double pause = 2;     // how long to pause timer for

   ALLEGRO_TIMER       *timer1  = null;
   ALLEGRO_TIMER       *timer2  = null;
   ALLEGRO_EVENT_QUEUE *queue   = null;

   if (!al_init()) {
      abort_example("Could not init Allegro.\n");
   }

   printf("Creating a pair of %2.0fs timers\n", duration);
   queue = al_create_event_queue();
   timer1 = al_create_timer(duration);
   timer2 = al_create_timer(duration);
   al_register_event_source(queue, al_get_timer_event_source(timer1));
   al_register_event_source(queue, al_get_timer_event_source(timer2));

   printf("Starting both timers at: %2.2fs\n", al_get_time());
   al_start_timer(timer1);
   al_start_timer(timer2);
   al_rest(pre_pause);

   printf("Pausing timers at: %2.2fs\n", al_get_time());
   al_stop_timer(timer1);
   al_stop_timer(timer2);
   al_rest(pause);

   printf("Resume  timer1 at: %2.2fs\n", al_get_time());
   al_resume_timer(timer1);

   printf("Restart timer2 at: %2.2fs\n", al_get_time());
   al_start_timer(timer2);

   ALLEGRO_EVENT ev;

   al_wait_for_event(queue, &ev);
   printf("Timer%d finished at: %2.2fs\n",
         al_get_timer_event_source(timer1) == ev.any.source ? 1 : 2,
         al_get_time());

   al_wait_for_event(queue, &ev);
   printf("Timer%d finished at: %2.2fs\n",
         al_get_timer_event_source(timer1) == ev.any.source ? 1 : 2,
         al_get_time());

   al_destroy_event_queue(queue);
   al_destroy_timer(timer1);
   al_destroy_timer(timer2);

   return 0;
}
