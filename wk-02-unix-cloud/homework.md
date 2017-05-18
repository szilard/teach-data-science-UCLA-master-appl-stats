# The problem statement, all variables and given/known data:

Write a parser script for a web server access log that will provide the statistics outlined below. Remember to format your output in a neat form. You may complete this assignment with one script or a shell script using a combination of Awk/cut scripts. Be creative!

Obtain the file located at http://users.csc.tntech.edu/~elbrown/access_log.bz2. For full credit, you must not save this data file to disk. You must process the file by reading directly from the url above using bash commands.

Your script should address each of the following items:

1. List the top 10 web sites from which requests came (non-404 status, external addresses looking in).
2. List the top 10 local web pages requested (non-404 status).
3. List the top 10 web browsers used to access the site. It is not necessary to get fancy and parse out all of the browser string. Simply print out the information that is there. Display the percentage of all browser types that each line represents.
4. List the number of 404 errors that were reported in the log. 
5. List the number of 500 errors that were reported in the log. 
6. Add any other important information that you deem appropriate.

2. Relevant commands, code, scripts, algorithms:

Awk can be used. You can also probably use `cut` and other things. An `awk` tutorial is available [here](http://www.grymoire.com/Unix/Awk.html)

# Turning In Your Homework

**WORK IS DUE MAY 3 LATE WORK WILL NOT BE ACCEPTED**

Add me as a contributor to your project (my username is earino), and email me a link to a `run` for your solution. [This](https://trial.dominodatalab.com/u/earino/stat-418-week-2/runs/58f800ac5c1425980009a0a2) is an example of a run on my domino project. You will need to send me one for your project.

I have modified the project and added a [starter.sh](https://trial.dominodatalab.com/u/earino/stat-418-week-2/view/starter.sh) script to get you started.

