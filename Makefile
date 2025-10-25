NASM = nasm
NASMFLAGS = -f elf64
AR = ar
ARFLAGS = rcs

NAME = libasm.a
SRC_DIR = src
OBJ_DIR = obj

SRC = ft_strlen.s \
#       ft_strcpy.s \
#       ft_strcmp.s \
#       ft_write.s \
#       ft_read.s \
#       ft_strdup.s

SRCS = $(addprefix $(SRC_DIR)/, $(SRC))
OBJS = $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(SRCS))

all: $(NAME)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)

re: fclean all
