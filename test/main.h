#ifndef MAIN_H
# define MAIN_H 

#include "stdio.h"
#include "unistd.h"
#include "fcntl.h"
#include "errno.h"
#include "../bonus_src/ft_list.h"

size_t	ft_strlen(const char *str);
void	test_ft_strlen();

char*	ft_strcpy(char *restrict dst, const char *restrict src);
void	test_ft_strcpy();

int		ft_strcmp(const char *s1, const char *s2);
void	test_ft_strcmp();

ssize_t ft_write(int fd, const void *buf, size_t count);
void	test_ft_write();

ssize_t ft_read(int fd, void *buf, size_t count);
void	test_ft_read();

char*   ft_strdup(const char *s);
void    test_ft_strdup();

int     ft_atoi_base(const char *str, int base);
void    test_ft_atoi_base();

void    ft_list_push_front(t_list **begin_list, void *data);
void    test_ft_list_push_front();

int     ft_list_size(t_list *begin_list);
void    test_ft_list_size(); 
#endif