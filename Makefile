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
		src/strlen.asm	\
		src/strncmp.asm	\
		src/strpbrk.asm	\
		src/strrchr.asm	\
		src/strstr.asm	\

OBJ	=	$(SRC:.asm=.o)

%.o: %.asm
	nasm -f elf64 $<

NAME	=	libasm.so

all:	$(NAME)
.PHONY:	all

$(NAME):	$(OBJ)
	ld -shared -fPIC -o $(NAME) $(OBJ)

clean:
	find -name "*.o" -delete
.PHONY:	clean

fclean:	clean
	rm -f $(NAME)
.PHONY:	fclean

re: fclean all
.PHONY:	re
