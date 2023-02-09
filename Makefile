##
## EPITECH PROJECT, 2023
## Assembly
## File description:
## Makefile
##

SRC	=	src/memset.asm	\
		src/memcpy.asm	\
		src/memmove.asm	\
		src/strcasecmp.asm	\
		src/strchr.asm	\
		src/strcmp.asm	\
		src/strcspn.asm	\
		src/strlen.asm	\
		src/strncmp.asm	\
		src/strpbrk.asm	\
		src/strrchr.asm	\
		src/strstr.asm	\

SRC_BONUS	=	bonus/strcpy.asm	\
				bonus/strncpy.asm	\
				bonus/index.asm	\
				bonus/rindex.asm	\
				bonus/memfrob.asm	\

OBJ	=	$(SRC:.asm=.o) $(SRC_BONUS:.asm=.o)

SRC_TESTS	=	tests/tests.c	\

OBJ_TESTS	=	$(SRC_TESTS:.c=.o)

NAME_TESTS	=	unit_tests

%.o: %.asm
	nasm -f elf64 $<

CPPFLAGS	=	--coverage

CFLAGS	=	-fprofile-arcs -ftest-coverage

LDFLAGS	=	-L.

LDLIBS	=	-lasm -lcriterion -lgcov

NAME	=	libasm.so

NAME_BONUS	=	libmoreasm.so

all:	$(NAME)
.PHONY:	all

$(NAME):	$(OBJ)
	ld -shared -fPIC -o $(NAME) $(OBJ)

bonus:	$(OBJ_BONUS)
	ld -shared -fPIC -o $(NAME_BONUS) $(OBJ_BONUS)

tests_run:	fclean $(OBJ_TESTS) $(NAME)
	gcc -o $(NAME_TESTS) $(OBJ_TESTS) $(LDFLAGS) $(LDLIBS)
	-./$(NAME_TESTS)
.PHONY: tests_run

clean:
	find -name "*.o" -delete
	find -name "*.gc*" -delete
.PHONY:	clean

fclean:	clean
	rm -f $(NAME)
	rm -f $(NAME_BONUS)
	rm -f $(NAME_TESTS)
.PHONY:	fclean

re: fclean all
.PHONY:	re
