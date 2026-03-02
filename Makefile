NASM = nasm
NASMFLAGS = -f elf64
CC = cc
CFLAGS = -Wall -Wextra -Werror -no-pie
AR = ar
ARFLAGS = rcs

NAME = libasm.a
SRC_DIR = src
OBJ_DIR = obj
TEST_DIR = test
TEST_BIN = libasm_test

SRC = ft_strlen.s \
	ft_strcpy.s \
	ft_strcmp.s \
	ft_write.s \
	ft_read.s \
	ft_strdup.s

SRCS = $(addprefix $(SRC_DIR)/, $(SRC))
OBJS = $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(SRCS))

all: $(NAME)

test: $(NAME)
	$(CC) $(CFLAGS) -I$(TEST_DIR) $(TEST_DIR)/main.c $(NAME) -o $(TEST_BIN)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s
	@mkdir -p $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) $< -o $@

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)
	rm -f $(TEST_BIN)

re: fclean all
