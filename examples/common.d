/*
 * Many core allegro examples use functionality from common.c.
 * This module mirros that file, making it easier to port examples.
 * Currently it only writes to the console, unlike common.c which opens a log
 * dialog (if enabled during compilation).
 */
module common;

import std.stdio;

void init_platform_specific() { }

void abort_example(T...)(string format, T args)
{
   stderr.writefln(format, args);
}

void open_log() { }

void open_log_monospace() { }

void close_log(bool wait_for_user) { }

void log_printf(T...)(string format, T args)
{
   writefln(format, args);
}

/* vim: set sts=3 sw=3 et: */
