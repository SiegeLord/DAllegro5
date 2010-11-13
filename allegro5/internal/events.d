module allegro5.internal.events;

extern (C)
{
   struct ALLEGRO_USER_EVENT;
   struct ALLEGRO_USER_EVENT_DESCRIPTOR
   {
      void (*dtor)(ALLEGRO_USER_EVENT *event);
      int refcount;
   };
}
