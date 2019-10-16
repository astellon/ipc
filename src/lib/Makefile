PROGRAM = libipc libshm
CC = gcc

all: $(PROGRAM) clean

%: %.c
	$(CC) -o $@ $^
	./$@

clean:
	rm -f $(PROGRAM)

cleanall: clean
	rm -f $(PROGRAM:=.cr)