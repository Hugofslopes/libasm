#include "main.h"

int	main ()
{
	test_ft_strlen();
	write(1, "\n", 1);

	test_ft_strcpy();
	write(1, "\n", 1);

	test_ft_strcmp();
	write(1, "\n", 1);

	test_ft_write();
	write(1, "\n", 1);

	test_ft_read();
	return 0;
}

void	test_ft_strlen()
{
	printf("\033[32mTesting ft_strlen:\033[0m\n");

	char	*str = "OlaOla";
	
	errno = 0;
	int		a = ft_strlen(str);
	printf("The value is : %d\n", a);
	perror("ft_strlen");
	printf("errno: %d\n", errno);

	errno = 0;
	str = NULL;
	a = ft_strlen(str);
	printf("The value is : %d\n", a);
	perror("ft_strlen");
	printf("errno: %d\n", errno);
}

void	test_ft_strcpy()
{
	printf("\033[32mTesting ft_strcpy:\033[0m\n");

	char	*src = "OlaOla";
	char 	dst[7];
	
	errno = 0;
	ft_strcpy(dst, src);
	printf("Dest string has : %s\n", dst);
	perror("ft_strcpy");
	printf("errno: %d\n", errno);

}

void	test_ft_strcmp()
{
	printf("\033[32mTesting ft_strcmp:\033[0m\n");

	char *s1 = "OlaOla";
	char *s2 = "OlaOla";
	char *s3 = "OlaOlA";
	char *s4 = "olaOla";
	char *s5 = "";
	char *s6 = NULL;

	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s1,s2));
	perror("Comparison");
	printf("errno: %d\n", errno);

	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s1,s3));
	perror("Comparison");
	printf("errno: %d\n", errno);
	
	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s1,s4));
	perror("Comparison");
	printf("errno: %d\n", errno);
	
	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s1,s5));
	perror("Comparison");
	printf("errno: %d\n", errno);
	
	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s5,s1));
	perror("Comparison");
	printf("errno: %d\n", errno);
	
	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s1,s6));
	perror("Comparison");
	printf("errno: %d\n", errno);

	errno = 0;
	printf("The cmp has returned: %d\n", ft_strcmp(s6,s1));
	perror("Comparison");
	printf("errno: %d\n", errno);
}

void	test_ft_write()
{	
	printf("\033[32mTesting ft_write:\033[0m\n");

	char*	str = "OlaOla\n";

	errno = 0;
	ssize_t ret = ft_write(1, str, 7);
	printf("ft_write returned: %zd\n", ret);
	perror("ft_write");
	printf("errno: %d\n", errno);

	errno = 0;
	ret = ft_write(-1, str, 7);
	printf("ft_write returned: %zd\n", ret);
	perror("ft_write");
	printf("errno: %d\n", errno);
}

void	test_ft_read()
{
	printf("\033[32mTesting ft_read:\033[0m\n");

	char	buffer[100];
	int		fd = open("test/test.txt", 2);
	
	errno = 0;
	ssize_t	ret = ft_read(fd, buffer, 100);

	if (ret >= 0)
	{
		buffer[ret] = '\0';
		printf("Read from file: %s\n", buffer);
	}
	else
	{
		printf("ft_read returned: %zd\n", ret);
	}
	perror("ft_read");
	printf("errno: %d\n", errno);

	errno = 0;
	ret = ft_read(-1, buffer, 100);

	if (ret >= 0)
	{
		buffer[ret] = '\0';
		printf("Read from stdin: %s\n", buffer);
	}
	else
	{
		printf("ft_read returned: %zd\n", ret);
	}
	perror("ft_read");
	printf("errno: %d\n", errno);
}