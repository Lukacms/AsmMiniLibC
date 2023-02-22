# ASM - mini lib c

## Project
The goal is to make some of the glibc functions in assembly x86_64.<br>
All the mandatory functions to reproduce are in the `src` folder and are the following:
|   Function            |   Description and C prototype                   |
| --------------------- | ----------------------------------------------- |
| `memcpy`     | <b>void *memcpy(void dest[restrict .n], const void src[restrict .n],size_t n);</b><br>copies n bytes from memory area src to memory area dest.    |
| `memmove`    | <b>void *memmove(void dest[.n], const void src[.n], size_t n);</b><br>copies n bytes from memory area src to memory area dest.  The memory areas may overlap.  |
| `strcasecmp` | <b>int strcasecmp(const char *s1, const char *s2);</b><br>Performs a byte-by-byte comparison of the strings s1 and s2, ignoring the case of the characters.<br>It returns an integer less than, equal to, or greater than zero if s1 is found, respectively, to be less than, to match, or be greater than s2.  |
| `strchr`     | <b>char *strchr(const char *s, int c);</b><br>It returns a pointer to the first occurrence of the character c in the string s.    |
| `strcmp`     | <b>int strcmp(const char *s1, const char *s2);</b><br>Compares the two strings s1 and s2.<br>It returns a negative value if s1 < s2, positive if s1 > s2 or 0 if s1 == s2 |
| `strcspn`    | <b>size_t strcspn(const char *s, const char *reject);</b><br>Calculates the length of the initial segment of s which consists entirely of bytes not in reject.    |
| `strlen`     | <b>size_t strlen(const char *s);</b><br>Calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').    |
| `strncmp`    | <b>int strncmp(const char s1[.n], const char s2[.n], size_t n);</b><br>Similar to `strcmp`, except it compares only the first (at most) n bytes of s1 and s2.   |
| `strpbrk`    | <b>char *strpbrk(const char *s, const char *accept);</b><br>Locates the first occurrence in the string s of any of the bytes in the string accept.    |
| `strrchr`    | <b>char *strrchr(const char *s, int c);</b><br>Returns a pointer to the last occurrence of the character c in the string s.    |
| `strstr`     | <b>char *strcasestr(const char *haystack, const char *needle);</b><br>Finds the first occurrence of the substring needle in the string haystack.  The terminating null bytes ('\0') are not compared.    |


More functions have been done, and can be found in the `bonus` folder:
*   `index`
*   `memfrob`
*   `rindex`
*   `strcpy`
*   `strncpy`

## How to build project ?
A Makefile is used to compile the code, and it use the following rules:

| Command          | Result                                          |
| ---------------- | ----------------------------------------------- |
| `make`           | Builds a ```libasm.so``` executable.          |
| `make clean`     | Cleans build dumps, keeping the executable.     |
| `make fclean`    | Removes all of the files created by the build.  |
| `make tests_run`    | Execute the criterion tests.  |
| `make re`        | Calls `make fclean` and then `make`.            |

## Author
[Luka Camus](https://github.com/Lukacms/)
