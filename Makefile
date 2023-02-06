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

OBJ_BONUS	=	$(SRC:.asm=.o) $(SRC_BONUS:.asm=.o)

OBJ	=	$(SRC:.asm=.o)

%.o: %.asm
	nasm -f elf64 $<

NAME	=	libasm.so

NAME_BONUS	=	libmoreasm.so

all:	$(NAME)
.PHONY:	all

$(NAME):	$(OBJ)
	ld -shared -fPIC -o $(NAME) $(OBJ)

bonus:	$(OBJ_BONUS)
	ld -shared -fPIC -o $(NAME_BONUS) $(OBJ_BONUS)

clean:
	find -name "*.o" -delete
.PHONY:	clean

fclean:	clean
	rm -f $(NAME)
	rm -f $(NAME_BONUS)
.PHONY:	fclean

re: fclean all
.PHONY:	re
