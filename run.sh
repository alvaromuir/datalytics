#!/bin/sh
(coffee -wc -o ./ src/*.coffee \
 & coffee -wc -o ./models src/models/*.coffee \
 & coffee -wc -o ./views src/views/*.coffee \
 & coffee -wc -o ./views/scripts src/views/scripts/*.coffee \
 & coffee -wc -o ./controllers src/controllers/*.coffee \
 & coffee -wc -o ./tools src/tools/*.coffee \
 & coffee -wc -o ./test src/test/*.coffee \
 & nodemon | bunyan -j)
