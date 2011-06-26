#!/bin/sh

ldc -c -oq -od=.objs/ -release allegro5/*.d allegro5/internal/*.d $@
ar -r libdallegro5.a .objs/*.o
