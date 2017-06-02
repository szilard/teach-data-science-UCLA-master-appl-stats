
### Sample exam questions:


#### Unix/cloud/repro/datavis/shiny

**0.** What is UNIX

**1.** Describe briefly the unix shell

**2.** Describe the use of the unix cut command

**3.** Describe the use of the unix awk command

**4.** Describe the model of unix pipes

**5.** Describe how the unix sort and uniq commands differ and how they are similar

**6.** How does the unix file permission model work

**7.** Is there a way to erase all files in the current directory, including all its sub-directories, using only one command

**8.** Describe the model of string interpolation in the unix shell

**9.** Compare and contrast relative vs absolute paths

**10.** Write a command to download the file http://example.com/data.csv.gz, unzip it, and find the number of unique values of the 4th column of the file.

#### DataViz

**1.** I described 7 possible things you can visualize, what are they?

**2.** Describe uses of a diverging bar, when is it appropriate, draw one.

**3.** Describe uses of a spine chart, when is it appropriate, draw one.

**4.** Describe uses of an area chart, when is it appropriate, draw one.

**5.** Describe uses of a scatterplot, when is it appropriate, draw one.

**6.** Describe uses of a bubble chart, when is it appropriate, draw one.

**7.** Describe uses of a heatmap,  when is it appropriate, draw one.

**8.** Describe uses of a linechart, when is it appropriate, draw one.

**9.** Name the major components of the grammar of graphics.

**10.** Using ggplot and the iris dataset, what is the command for a scatterplot of Sepal Length and Width colored by species with dot area scaled by the difference between petal width and length?

**11.** Describe the major components of a Shiny application

**12.** Why won't this shiny code run:

```
library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Old Faithful Geyser Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))

shinyServer(function(input, output) {
  
  output$plotOutput <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
})
```

#### Reproducibility

**1.** Define repeatability in the context of research

**2.** Define reproducibility in the context of research

**3.** Define replicability in the context of research

**4.** Define computational reproducibility

**5.** Define empirical reproducibility

**6.** Define statistical reproducibility

**7.** What is the primary difference in the execution lifecycle of a jupyter notebook vs a knitR document

**8.** List and explain the components of a knitR document

**9.** What is meant by the statement "shiny is a reactive framework"

**10.** What are the commands to retrieve a git repository from github, modify a file, commit it, and push it back to github

#### Machine learning

**1.** Describe briefly the steps in a typical data science project.

**2.** Describe the supervised learning problem in general.

**3.** Why do we need a test set? 

**4.** Why are evaluation metrics calculated from the training set misleading?

**5.** What is gradient descent?

**6.** How do we do cross validation for model evaluation?

**7.** How does the train and test error change vs model complexity?

**8.** Describe overfitting.

**9.** How do we select models with grid/random search?

**10.** What is an ROC curve?

**11.** What is regularization? Give an example.

**12.** Describe the LASSO.

**13.** Describe decision trees and how we fit them.

**14.** Compare random forests and GBMs.

**15.** Describe the main tuning parameters for GBMs. How do they relate to model complexity?

**16.** Describe 3 tricks in training neural networks. 

**17.** Describe grid and random search for hyper-parameter tuning.

**18.** What are ensembles? What are some of the advantages and disadvantages of using them.

**19.** Describe k-means clustering.

**20.** Describe hierarchical clustering.


#### Databases/big data

**1.** List at least 3 defining features of the relational model. 

**2.** For each of the following acronyms, write what the letters standard for, 
and then give a short definition of the concept (1-2 sentences): 
- ETL
- SQL
- CRUD
- RDBMS 

**3.** Define the term ‘schema’. 

**4.** Check any of the following which must be defined by the schema in a relational database system:
- field names
- table dimensions
- operating system version
- field types
- primary key
- programming language
- table names

**5a.** What does it mean to say that redis is an in-memory store? (1-2 sentences)

**5b.** What is the primary advantage of using an in-memory datastore? (1 sentence)

**5c.** What is the primary disadvantage of using an in-memory datastore? (1 sentence)

**6.** Check any of the following that you would expect to see included in a connection string: 
- number of records
- programming language
- host
- port
- username
- client type
- database version
- password
- filename

**7a.** What does it mean to say that our software or system is ‘distributed’? (1-2 sentences)

**7b.** What is the primary advantage or motivation for using a distributed system? (1 sentence)

**7c.** What is the primary disadvantage of using a distributed system? (1 sentence)

**8.** What does HDFS stand for. What problem does HDFS solve? 

**9.** In Apache Spark, what does the acronym RDD stand for. What problem does the RDD solve? 

**10.** Why are there so many types of databases? 


