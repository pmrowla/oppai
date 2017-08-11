#!/bin/sh

dir=$(dirname $0)
if [ $(uname) = "Darwin" ]; then
    brew_prefix=$(brew --prefix)
    ${CXX:-clang++}                        \
        -I$brew_prefix/opt/openssl/include \
        -L$brew_prefix/opt/openssl/lib     \
        -std=c++98                         \
        -pedantic                          \
        -O3                                \
        $@                                 \
        -Wno-variadic-macros -Wall         \
        $dir/main.cc                       \
        -lm -lstdc++                       \
        -lcrypto                           \
        -o oppai
else
    ${CXX:-g++}                    \
        -std=c++98                 \
        -pedantic                  \
        -O3                        \
        $@                         \
        -Wno-variadic-macros -Wall \
        $dir/main.cc               \
        -lm -lstdc++               \
        -lcrypto                   \
        -o oppai
    [ -f ./oppai ] && strip -R .comment ./oppai
fi
