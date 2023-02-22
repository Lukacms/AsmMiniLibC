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

Test(test_memfrob, basic, .init = init_fun)
{
    char *str = strdup("test");
    cr_assert_eq(my_memfrob(str, strlen(str)), memfrob(str, strlen(str)));
    cr_assert_eq(my_memfrob(str, 2), memfrob(str, 2));
    cr_assert_eq(my_memfrob(str, 0), memfrob(str, 0));
    cr_assert_eq(my_memfrob("", 0), memfrob("", 0));
}
