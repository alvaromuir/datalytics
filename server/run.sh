#!/bin/sh
(coffee -wc -o . src & nodemon | bunyan -j)
