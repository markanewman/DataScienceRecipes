summary.dsr1_train_all <-
  function(fits) {
    gather_results <- function(fit) {
      result <-
        list(
          model = attr(fit, 'model'),
          accuracy = as.numeric(NA),
          ci_lower = as.numeric(NA),
          ci_upper = as.numeric(NA),
          time = attr(fit, 'time'))
      if(class(fit)[1] == 'train') {
        td <- fit$trainingData
        pre <- predict(fit, td)
        cm <- caret::confusionMatrix(reference = td$.outcome, data = pre, positive = levels(td$.outcome)[2])
        result$accuracy = 100 * unname(cm$overall['Accuracy'])
        result$ci_lower = 100 * unname(cm$overall['AccuracyLower'])
        result$ci_upper = 100 * unname(cm$overall['AccuracyUpper'])
      }
      result
    }
    results <-
      data.frame(
        model = character(),
        accuracy = numeric(),
        ci_lower = character(),
        ci_upper = character(),
        time = double())
    for(fit in fits) {
      results <- rbind(results, gather_results(fit))
    }
    indx <- order(results$accuracy, decreasing = T)
    results <- results[indx,]
    rownames(results) <- NULL
    results
  }
