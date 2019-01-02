#!/bin/bash

mkdir -p bin
gcc -o bin/$1 $1.s
