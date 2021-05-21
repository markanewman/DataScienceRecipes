classify_all <-
  function(
    formula,
    data,
    k = 10,
    split = .8,
    models = c('null', 'glm', 'rf', 'ctree', 'cforest', 'pls', 'gbm', 'pda', 'svmLinear', 'svmRadial', 'tan', 'awtan', 'fda', 'knn', 'evtree'),
    show_progress = interactive()) {
    i.train <- function(formula, data, tCtrl) { UseMethod('i.train', tCtrl) }
    i.train.default <- function(formula, data, tCtrl) {
      tcc <- class(tCtrl)
      train(
        form = formula,
        data = data,
        trControl = tCtrl,
        method = tcc[length(tcc)])
    }
    i.train.glm <- function(formula, data, tCtrl) {
      tcc <- class(tCtrl)
      train(
        form = formula,
        data = data,
        trControl = tCtrl,
        method = tcc[length(tcc)],
        family = 'binomial')
    }
    tCtrl <-
      trainControl(
        method = 'cv',
        number = k,
        p = split,
        sampling = 'down')
    tcc <- class(tCtrl)
    results <-
      data.frame(
        model = character(),
        accuracy = numeric(),
        ci_lower = character(),
        ci_upper = character(),
        time = double())
    if(show_progress) { pb <- utils::txtProgressBar(max = length(models), style = 3) }
    for(i in 1:length(models)) {
      if(show_progress) { utils::setTxtProgressBar(pb, i) }
      class(tCtrl) <- c(tcc, models[i])
      then <- Sys.time()
      fit <- i.train(formula, data, tCtrl)
      now <- Sys.time()
      td <- fit$trainingData
      pre <- predict(fit, td)
      cm <- confusionMatrix(reference = td$.outcome, data = pre, positive = levels(td$.outcome)[2])
      results <-
        rbind(
          results,
          list(
            'model' = models[i],
            'accuracy' = 100 * unname(cm$overall['Accuracy']),
            'ci_lower' = 100 * unname(cm$overall['AccuracyLower']),
            'ci_upper' = 100 * unname(cm$overall['AccuracyUpper']),
            'time' = as.double(difftime(now, then, units = "secs"))))
      rm(fit, td, pre, cm, then, now)
    }
    if(show_progress) { close(pb); rm(pb) }
    results
  }
