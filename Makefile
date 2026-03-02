NASM = nasm
NASMFLAGS = -f elf64
CC = cc
CFLAGS = -Wall -Wextra -Werror -no-pie
AR = ar
ARFLAGS = rcs

NAME = libasm.a
SRC_DIR = src
BONUS_DIR = bonus_src
OBJ_DIR = obj
TEST_DIR = test
TEST_BIN = libasm_test

SRC = ft_strlen.s \
	ft_strcpy.s \
	ft_strcmp.s \
	ft_write.s \
	ft_read.s \
	ft_strdup.s

BONUS_SRC = ft_atoi_base.s \
	ft_list_push_front.s \
	ft_list_size.s \
	ft_list_sort.s

SRCS = $(addprefix $(SRC_DIR)/, $(SRC))
BONUS_SRCS = $(addprefix $(BONUS_DIR)/, $(BONUS_SRC))

OBJS = $(patsubst $(SRC_DIR)/%.s, $(OBJ_DIR)/%.o, $(SRCS))
BONUS_OBJS = $(patsubst $(BONUS_DIR)/%.s, $(OBJ_DIR)/%.o, $(BONUS_SRCS))

DEPS = $(patsubst $(OBJ_DIR)/%.o, $(OBJ_DIR)/%.d, $(OBJS))
BONUS_DEPS = $(patsubst $(OBJ_DIR)/%.o, $(OBJ_DIR)/%.d, $(BONUS_OBJS))

all: $(NAME)

bonus: .bonus

.bonus: $(OBJS) $(BONUS_OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS) $(BONUS_OBJS)
	@touch .bonus

test: $(NAME)
	$(CC) $(CFLAGS) -I$(TEST_DIR) $(TEST_DIR)/main.c $(NAME) -o $(TEST_BIN)

$(NAME): $(OBJS)
	$(AR) $(ARFLAGS) $(NAME) $(OBJS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.s | $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) -MD $(OBJ_DIR)/$*.d $< -o $@

$(OBJ_DIR)/%.o: $(BONUS_DIR)/%.s | $(OBJ_DIR)
	$(NASM) $(NASMFLAGS) -MD $(OBJ_DIR)/$*.d $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

clean:
	rm -rf $(OBJ_DIR)

fclean: clean
	rm -f $(NAME)
	rm -f $(TEST_BIN)
	rm -f .bonus

re: fclean all

-include $(DEPS)
-include $(BONUS_DEPS)
