#include <stdio.h>
#include <string.h>

size_t ft_strlen(const char *str);  // Declaration of your assembly function

int main()
{
    // Test cases
    const char *test1 = "Hello";
    const char *test2 = "";
    const char *test3 = "42 School!";
    const char *test4 = "This is a longer string to test";

    // Compare your ft_strlen with the original strlen
    printf("Test 1: \"%s\"\n", test1);
    printf("ft_strlen: %zu\n", ft_strlen(test1));
    printf("strlen   : %zu\n\n", strlen(test1));

    printf("Test 2: empty string\n");
    printf("ft_strlen: %zu\n", ft_strlen(test2));
    printf("strlen   : %zu\n\n", strlen(test2));

    printf("Test 3: \"%s\"\n", test3);
    printf("ft_strlen: %zu\n", ft_strlen(test3));
    printf("strlen   : %zu\n\n", strlen(test3));

    printf("Test 4: \"%s\"\n", test4);
    printf("ft_strlen: %zu\n", ft_strlen(test4));
    printf("strlen   : %zu\n\n", strlen(test4));

    return 0;
}