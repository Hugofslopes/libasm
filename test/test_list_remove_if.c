#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../bonus_src/list.h"

// External function to test
void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

// Comparison function for integers
int cmp_int(void *a, void *b)
{
	return (*(int *)a - *(int *)b);
}

// Comparison function for strings
int cmp_str(void *a, void *b)
{
	return strcmp((char *)a, (char *)b);
}

// Free function that just calls free
void free_data(void *data)
{
	free(data);
}

// Create a new list node
t_list *create_node(void *data)
{
	t_list *node = malloc(sizeof(t_list));
	if (!node)
		return NULL;
	node->data = data;
	node->next = NULL;
	return node;
}

// Print integer list
void print_int_list(t_list *list)
{
	printf("List: ");
	while (list)
	{
		printf("%d", *(int *)list->data);
		if (list->next)
			printf(" -> ");
		list = list->next;
	}
	printf("\n");
}

// Print string list
void print_str_list(t_list *list)
{
	printf("List: ");
	while (list)
	{
		printf("%s", (char *)list->data);
		if (list->next)
			printf(" -> ");
		list = list->next;
	}
	printf("\n");
}

// Free entire list
void free_list(t_list *list, void (*free_fct)(void *))
{
	t_list *tmp;
	while (list)
	{
		tmp = list->next;
		if (free_fct)
			free_fct(list->data);
		free(list);
		list = tmp;
	}
}

// Test 1: Remove integers from the middle
void test_remove_middle()
{
	printf("\n=== Test 1: Remove matching integers from middle ===\n");
	
	int *nums[5];
	for (int i = 0; i < 5; i++)
	{
		nums[i] = malloc(sizeof(int));
		*nums[i] = i + 1;  // 1, 2, 3, 4, 5
	}
	
	t_list *list = create_node(nums[0]);
	list->next = create_node(nums[1]);
	list->next->next = create_node(nums[2]);
	list->next->next->next = create_node(nums[3]);
	list->next->next->next->next = create_node(nums[4]);
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 3;
	ft_list_remove_if(&list, &ref, cmp_int, free_data);
	
	printf("After removing 3: ");
	print_int_list(list);
	
	free_list(list, free_data);
}

// Test 2: Remove from head
void test_remove_head()
{
	printf("\n=== Test 2: Remove from head ===\n");
	
	int *nums[5];
	for (int i = 0; i < 5; i++)
	{
		nums[i] = malloc(sizeof(int));
		*nums[i] = i + 1;
	}
	
	t_list *list = create_node(nums[0]);
	list->next = create_node(nums[1]);
	list->next->next = create_node(nums[2]);
	list->next->next->next = create_node(nums[3]);
	list->next->next->next->next = create_node(nums[4]);
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 1;
	ft_list_remove_if(&list, &ref, cmp_int, free_data);
	
	printf("After removing 1: ");
	print_int_list(list);
	
	free_list(list, free_data);
}

// Test 3: Remove multiple consecutive matches
void test_remove_multiple()
{
	printf("\n=== Test 3: Remove multiple consecutive matches ===\n");
	
	int *nums[7];
	int values[] = {5, 5, 1, 2, 5, 5, 3};
	for (int i = 0; i < 7; i++)
	{
		nums[i] = malloc(sizeof(int));
		*nums[i] = values[i];
	}
	
	t_list *list = create_node(nums[0]);
	t_list *current = list;
	for (int i = 1; i < 7; i++)
	{
		current->next = create_node(nums[i]);
		current = current->next;
	}
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 5;
	ft_list_remove_if(&list, &ref, cmp_int, free_data);
	
	printf("After removing all 5s: ");
	print_int_list(list);
	
	free_list(list, free_data);
}

// Test 4: Remove all elements
void test_remove_all()
{
	printf("\n=== Test 4: Remove all elements ===\n");
	
	int *nums[3];
	for (int i = 0; i < 3; i++)
	{
		nums[i] = malloc(sizeof(int));
		*nums[i] = 42;
	}
	
	t_list *list = create_node(nums[0]);
	list->next = create_node(nums[1]);
	list->next->next = create_node(nums[2]);
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 42;
	ft_list_remove_if(&list, &ref, cmp_int, free_data);
	
	if (list == NULL)
		printf("After removing all 42s: List is empty (NULL)\n");
	else
		print_int_list(list);
}

// Test 5: Remove strings
void test_remove_strings()
{
	printf("\n=== Test 5: Remove matching strings ===\n");
	
	t_list *list = create_node(strdup("apple"));
	list->next = create_node(strdup("banana"));
	list->next->next = create_node(strdup("cherry"));
	list->next->next->next = create_node(strdup("banana"));
	list->next->next->next->next = create_node(strdup("date"));
	
	printf("Before: ");
	print_str_list(list);
	
	char *ref = "banana";
	ft_list_remove_if(&list, ref, cmp_str, free_data);
	
	printf("After removing 'banana': ");
	print_str_list(list);
	
	free_list(list, free_data);
}

// Test 6: No matches
void test_no_match()
{
	printf("\n=== Test 6: No matching elements ===\n");
	
	int *nums[4];
	for (int i = 0; i < 4; i++)
	{
		nums[i] = malloc(sizeof(int));
		*nums[i] = i + 1;
	}
	
	t_list *list = create_node(nums[0]);
	list->next = create_node(nums[1]);
	list->next->next = create_node(nums[2]);
	list->next->next->next = create_node(nums[3]);
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 99;
	ft_list_remove_if(&list, &ref, cmp_int, free_data);
	
	printf("After removing 99 (not in list): ");
	print_int_list(list);
	
	free_list(list, free_data);
}

// Test 7: NULL free function
void test_null_free()
{
	printf("\n=== Test 7: NULL free function (static data) ===\n");
	
	static int nums[] = {10, 20, 30, 40, 50};
	
	t_list *list = create_node(&nums[0]);
	list->next = create_node(&nums[1]);
	list->next->next = create_node(&nums[2]);
	list->next->next->next = create_node(&nums[3]);
	list->next->next->next->next = create_node(&nums[4]);
	
	printf("Before: ");
	print_int_list(list);
	
	int ref = 30;
	ft_list_remove_if(&list, &ref, cmp_int, NULL);
	
	printf("After removing 30: ");
	print_int_list(list);
	
	free_list(list, NULL);
}

int main(void)
{
	printf("========================================\n");
	printf("   ft_list_remove_if Test Suite\n");
	printf("========================================\n");
	
	test_remove_middle();
	test_remove_head();
	test_remove_multiple();
	test_remove_all();
	test_remove_strings();
	test_no_match();
	test_null_free();
	
	printf("\n========================================\n");
	printf("   All tests completed!\n");
	printf("========================================\n");
	
	return 0;
}
