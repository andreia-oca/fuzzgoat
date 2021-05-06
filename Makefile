CC=afl-gcc
DEPS=main.c fuzzgoat.c
CFLAGS=-I. -fprofile-arcs -ftest-coverage -coverage -g -w
LIBS=-lm

all: $(DEPS)
	$(CC) -o fuzzgoat $(CFLAGS) $^ $(LIBS)


no_vuln: main.c fuzzgoatNoVulns.c
	$(CC) -o no_vuln_fuzzgoat $(CFLAGS) $^ $(LIBS)

no_instr: main.c fuzzgoat.c
	gcc -o no_instr_fuzzgoat $(CFLAGS) $^ $(LIBS)

afl: fuzzgoat
	afl-fuzz -i in -o out ./fuzzgoat @@

.PHONY: clean

clean:
	rm ./fuzzgoat ./no_vuln_fuzzgoat ./no_instr_fuzzgoat

clean_coverage:
	rm -rf coverage.info coverage_stats *.gcda *.gcno *.gcov 

clean_all:
	rm -rf coverage.info coverage_stats *.gcda *.gcno *.gcov 
	rm ./fuzzgoat ./no_vuln_fuzzgoat ./no_instr_fuzzgoat