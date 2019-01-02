#!/bin/bash

mkdir -p bin
as -o bin/$1.o $1.s
ld -o bin/$1 bin/$1.o
./bin/$1

