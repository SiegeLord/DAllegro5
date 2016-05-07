# To build a particular example, use `make ex_<name>`, e.g. `make ex_dir`
DC=dmd

EXAMPLES := $(basename $(wildcard ex_*.d))

all: $(EXAMPLES)

clean:
	$(RM) *.o
	$(RM) $(EXAMPLES)

ex_%: ex_%.d
	$(DC) ex_$*.d common.d -I.. -L-L..
