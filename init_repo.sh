#!/bin/bash

# Script writed by nathan.toumoulin@epitech.eu
# You can use it as you need, it was created for fast repo install on Epitech CPool

echo "Initializing a repo for C language."
read -p "Enter the git repo: " repo
read -p "Enter the location where you want to init the repo: " location

echo "Adding the repo at the location..."
mkdir -p $location
cd $location

echo "Creating gitignore"
cat > .gitignore <<EOF
\#*#
*~
main.c
my_putchar.c
my_put_nbr.c
my_putstr.c
my_getnbr.c
*.out
tests
EOF

git init -b main
git add .gitignore
git commit -m "Add .gitignore"
git remote add origin "$repo"
git push -u origin main

echo "Adding testing files"
mkdir -p tests
cd tests
cat > my_put_nbr.c <<EOF
/*                                                                                                                                                                                                                   
** EPITECH PROJECT, 2026                                                                                                                                                                                             
** Tests                                                                                                                                                                                                             
** File description:                                                                                                                                                                                                 
** Some tests files                                                                                                                                                                                                  
*/
#include "libs.h"

static void print_limit(void)
{
    my_putchar('-');
    my_putchar('2');
    my_putchar('1');
    my_putchar('4');
    my_putchar('7');
    my_putchar('4');
    my_putchar('8');
    my_putchar('3');
    my_putchar('6');
    my_putchar('4');
    my_putchar('8');
}

int my_put_nbr(int nb)
{
    if (nb == -2147483648) {
        print_limit();
        return (0);
    }
    if (nb < 0) {
        my_putchar('-');
        nb = nb * -1;
    }
    if (nb >= 10) {
        my_put_nbr(nb / 10);
    }
    my_putchar((nb % 10) + 48);
    return (0);
}
EOF

cat > my_putstr.c <<EOF
/*
** EPITECH PROJECT, 2026
** Tests
** File description:
** Some tests files
*/
#include "libs.h"

static int my_length(char const *str)
{
    int len = 0;

    while (str[len] != '\0')
        len++;
    return len;
}

int my_putstr(char const *str)
{
    for (int i = 0; i < my_length(str); i++)
        my_putchar(str[i]);
    return (0);
}
EOF

cat > my_getnbr.c <<EOF
/*
** EPITECH PROJECT, 2026
** Tests
** File description:
** Some tests files
*/
#include <limits.h>

int my_getnbr(char const *str)
{
    long r = 0;
    int sign = 1;
    int i = 0;

    while (str[i] == '+' || str[i] == '-') {
        if (str[i] == '-')
            sign = -sign;
        i++;
    }
    while (str[i] >= '0' && str[i] <= '9') {
        r = r * 10 + (str[i] - '0');
        if (r * sign > INT_MAX || r * sign < INT_MIN)
            return (0);
        i++;
    }
    return (int)(r * sign);
}
EOF

cat > my_put_char.c <<EOF
/*
** EPITECH PROJECT, 2026
** Tests
** File description:
** Some tests files
*/
#include <unistd.h>

void my_putchar(char c)
{
    write(1, &c, 1);
}
EOF

cat > libs.h <<EOF
/*
** EPITECH PROJECT, 2026
** Tests
** File description:
** Some tests files
*/
#ifndef LIBS_H
    #define LIBS_H

void my_putchar(char c);

int my_put_nbr(int nb);

int my_putstr(char const *str);

int my_getnbr(char const *str);

#endif
EOF

cat > main.c <<EOF
/*
** EPITECH PROJECT, 2026
** Tests
** File description:
** Some tests files
*/
#include "libs.h"

int main(int ac, char **av)
{
    return 0;
}
EOF

echo "Initialization complete!"
