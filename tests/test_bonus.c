/*
** EPITECH PROJECT, 2023
** tests
** File description:
** test_bonus
*/

#define _GNU_SOURCE

#include <criterion/criterion.h>
#include <criterion/internal/assert.h>
#include <criterion/internal/test.h>
#include <criterion/redirect.h>
#include <dlfcn.h>
#include <gnu/lib-names.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static char *(*my_index)(char const *, int);
static void *(*my_memfrob)(void *, size_t);
static char *(*my_rindex)(const char *, int);
static char *(*my_strcpy)(char *, const char *);
static char *(*my_strncpy)(char *, const char *);

void init_fun()
{
    void *handle = dlopen("./libasm.so", RTLD_LAZY);

    if (!handle) {
        fprintf(stderr, "%s\n", dlerror());
        exit(EXIT_FAILURE);
    }
    my_index = dlsym(handle, "index");
    my_memfrob = dlsym(handle, "memfrob");
    my_rindex = dlsym(handle, "rindex ");
    my_strcpy = dlsym(handle, "strcpy ");
    my_strncpy = dlsym(handle, "strncpy ");
}

Test(test_index, basic, .init = init_fun)
{
    cr_assert_str_eq(my_index("Hello", 'e'), index("Hello", 'e'));
}

Test(test_index, index_not_in_str, .init = init_fun)
{
    cr_assert_null(my_index("Hello", 'u'));
    cr_assert_null(index("Hello", 'u'));
}

Test(test_index, index_more_than_one_time, .init = init_fun)
{
    cr_assert_str_eq(my_index("Hello", 'l'), index("Hello", 'l'));
}

Test(test_index, terminating_null_byte, .init = init_fun)
{
    cr_assert_str_eq(my_index("Hello", '\0'), index("Hello", '\0'));
}

Test(test_memfrob, basic, .init = init_fun)
{
    char *str = strdup("test");
    cr_assert_eq(my_memfrob(str, strlen(str)), memfrob(str, strlen(str)));
}

Test(test_memfrob, different_ind_1, .init = init_fun)
{
    char *str = strdup("bonsoir");
    cr_assert_eq(my_memfrob(str, 2), memfrob(str, 2));
}

Test(test_memfrob, different_ind_2, .init = init_fun)
{
    char *str = strdup("bonsoir");
    cr_assert_eq(my_memfrob(str, 0), memfrob(str, 0));
}

Test(test_memfrob, empty_strings, .init = init_fun)
{
    char *str = strdup("bonsoir");
    cr_assert_eq(my_memfrob("", 0), memfrob("", 0));
}
