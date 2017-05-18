#!/bin/bash

# this fetches the file and counts the number of lines. Add to this!

curl -s http://users.csc.tntech.edu/~elbrown/access_log.bz2 | bunzip2 - | wc -l 
