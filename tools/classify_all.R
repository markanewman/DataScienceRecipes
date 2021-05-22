classify_all <-
  function(
    formula,
    data,
    k = 10,
    split = .8,
    models = c('null', 'glm', 'rf', 'ctree', 'cforest', 'pls', 'gbm', 'pda', 'svmLinear', 'svmRadial', 'nb', 'tan', 'awtan', 'fda', 'knn', 'evtree'),
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
    gather_results <- function(formula, data, tCtrl) {
      assign('last.warning', NULL, envir = baseenv())
      then <- Sys.time()
      blank <- function() {
        list(
          accuracy = as.numeric(NA),
          ci_lower = as.numeric(NA),
          ci_upper = as.numeric(NA))
      }
      result <-
        tryCatch({
          xx <- capture.output(fit <- i.train(formula, data, tCtrl))
          td <- fit$trainingData
          pre <- predict(fit, td)
          cm <- confusionMatrix(reference = td$.outcome, data = pre, positive = levels(td$.outcome)[2])
          list(
            accuracy = 100 * unname(cm$overall['Accuracy']),
            ci_lower = 100 * unname(cm$overall['AccuracyLower']),
            ci_upper = 100 * unname(cm$overall['AccuracyUpper']))
          },
          error = function(e)  { blank() })
      result$time = as.double(difftime(Sys.time(), then, units = "secs"))
      result
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
      t1 <- gather_results(formula, data, tCtrl)
      results <- rbind(results, c(list(model = models[i]), t1))
      rm(t1)
    }
    if(show_progress) { close(pb); rm(pb) }
    results
  }
