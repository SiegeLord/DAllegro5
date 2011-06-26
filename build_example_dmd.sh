#!/bin/sh

dmd -release -ofexample example.d -L-L. $@
