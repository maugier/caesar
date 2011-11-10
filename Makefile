all:	names/fr/all.pl

clean:
	rm names/fr/all.pl

names/fr/all.pl:	names/fr/all
	./mkmatcher.pl <names/fr/all >names/fr/all.pl
