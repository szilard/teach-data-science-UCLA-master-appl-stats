
### Assignment #3


#### Due: 

Wednesday noon (Pacific time) on Week 8 (5/24)

Late submissions will be penalized and the penalty will grow with time.


#### How to submit:

Upload Rmarkdown (code) and html (results) files to a github repository. Send the URL/link via email
to @szilard with subject `STATS-418 HW-3`. 

Please do not attach files in email. Please use the email subject exactly like above. You must use
github for submissions, no other file repository (e.g. dropbox, domino etc). 
Any deviations will be penalized. 


#### Task:

Choose a public dataset for binary classification. The dataset must have at least 10000 positive and 10000 negative 
examples and at least 10 predictor variables (numeric or categorical).

Try various algorithms (LR, RF, GBM) with various implementations (R packages, h2o). Try various values for the
hyperparameters (tuning). For logistic regression try Lasso regularization with various values for lambda.
For random forest try various numbers of trees and tune the depth of the trees and the parameter governing 
the number of columns used in each split. For GBM tune at least the depth of trees and the learning rate (optionally
other parameters as well). For GBM use early stopping for determining the number of trees. Try also what happens
if you don't use early stopping and you overtrain (increasing the number of iterations/trees).

For all of the above use a proper split of train, validation and test set. If you use cross-validation be careful
how you do model selection.

Use AUC as a metric of goodness. Also plot the ROC curve in several cases and discuss the tradeoff of true
positives (TP) vs false positives (FP) in your particular problem. 

Document your findings. Submit a report that's not a mere dump of code and results, but contains an explanation
and discussion of your results. In real life you must "sell" your results across the business (your boss, other 
departments etc.)



