tableLinear <- function(data,
                           measurementVar,
                           selectedMeasurement,
                           covariate,
                           selectedSymptoms#,
                           #thresholdValue
                           ) { 

  # subset the data, using only the selected evaluation
  data <- data[data[,measurementVar]==selectedMeasurement, ]
  
#   # binarize the data
#   data[, selectedSymptoms] <- ifelse(data[, selectedSymptoms]>thresholdValue, 1, 0)
  
  table <- data.frame("Variable"=selectedSymptoms) # table of printable results - Fixed effect
  table2 <- data.frame("Variable"=selectedSymptoms) # table of raw results
  table3 <- data.frame("Variable"=selectedSymptoms) # table of printable results - Intercept
  
#   # check if covariate is binary and generate text which levels we are comparing
#   if (determineTypeofVariable(data[,covariate])[["nLevels"]]=="binary") { # binary var
#     levels <- levels(as.factor(data[,covariate])) # levels of the covariate
#     oddsFor <- paste(levels[2],"vs",levels[1]) # text describing which variables were compared
#   }
#   
#   if (determineTypeofVariable(data[,covariate])[["nLevels"]]=="multilevel" &  # numerical var w multi levels
#         ( determineTypeofVariable(data[,covariate])[["type"]]=="integer") 
#       | determineTypeofVariable(data[,covariate])[["type"]]=="numeric") { 
#     #levels <- levels(as.factor(data[,covariate])) # levels of the covariate
#     oddsFor <- paste("unit difference in", covariate) # text describing which variables were compared
#   }
#   
  for (symptom in selectedSymptoms) {
    model <- glm(data[,symptom] ~ data[,covariate], family=gaussian())
    table[table["Variable"]==symptom, "Beta (slope)"] <- 
      format(model$coef[2], digits=2)
    table[table["Variable"]==symptom, "95% conf. interval"] <- 
      paste(format((confint(model)[2,1]), digits=2),
            " to ",
            format((confint(model)[2,2]), digits=2))
    table2[table2["Variable"]==symptom, "beta"] <- (model$coef[2])
    table2[table2["Variable"]==symptom, "CILower"] <- (confint(model)[2,1])
    table2[table2["Variable"]==symptom, "CIUpper"] <- (confint(model)[2,2])
    table[table["Variable"]==symptom, "P value"] <-
      format(summary(model)$coefficients[2,"Pr(>|t|)"],digits=2)
    
    # printable table of intercepts
    table3[table3["Variable"]==symptom, "Intercept"] <- 
      format(model$coef[1], digits=2)
    table3[table3["Variable"]==symptom, "95% conf. interval"] <- 
      paste(format((confint(model)[1,1]), digits=2),
            " to ",
            format((confint(model)[1,2]), digits=2))
    table3[table["Variable"]==symptom, "P value"] <-
      format(summary(model)$coefficients[1,"Pr(>|t|)"],digits=2)
  }
  return(list(printableResultsTable=table,
              rawResultsTable=table2,
              printableInterceptTable=table3))
  
}



# head(mtcars)
# model <- glm(mtcars$mpg~mtcars$hp, family=gaussian)
# str(model)
# summary(model)
# confint(model)
# coef(model)
# model$coef[2]
