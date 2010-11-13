#!/bin/sh

dmd -release -ofexample example.d -L-lallegro_primitives -L-lallegro_ttf -L-lallegro_font -L-lallegro -L-lallegro_image -I. -L-L. -L-ldallegro5
