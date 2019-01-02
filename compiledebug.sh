#!/bin/bash

mkdir -p bin
as -g -o bin/$1.o $1.s
ld -o bin/$1 bin/$1.o
