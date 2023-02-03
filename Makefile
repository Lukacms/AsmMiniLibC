##
## EPITECH PROJECT, 2023
## Assembly
## File description:
## Makefile
##

SRC	=	src/strlen.asm	\
		src/strchr.asm	\
		src/strrchr.asm	\

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
