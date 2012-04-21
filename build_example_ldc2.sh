#!/bin/sh

ldc2 -w -release -ofexample example.d -L-L. $@
