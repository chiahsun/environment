
#.PHONY : all clean lib binary




clean :
	make -f ~/makefile/Makefile.binary.mk clean
	make -f ~/makefile/Makefile.ar.mk clean
	@ for DIR in $(CODE_DIRS); \
    	do \
			if test -d $$DIR; then (cd $$DIR; make clean); else echo "No such directory $$DIR"; fi \
		done


binary :
	make -f ~/makefile/Makefile.binary.mk

lib :
	make -f ~/makefile/Makefile.ar.mk

