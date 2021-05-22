fit_all <-
  function(
    formula,
    data,
    models = c('null', 'glm', 'rf', 'ctree', 'cforest', 'pls', 'gbm', 'pda', 'svmLinear', 'svmRadial', 'nb', 'tan', 'awtan', 'fda', 'knn', 'evtree'),
    k = 10,
    split = .8,
    show_progress = interactive()) {
    train_safe <- function(formula, data, tCtrl, model) {
      assign('last.warning', NULL, envir = baseenv())
      arg.list <-
        list(
          form = formula,
          data = data,
          trControl = tCtrl,
          method = model)
      if(model == 'glm') { arg.list$family = 'binomial'}
      xx <- capture.output(
        result <-
          tryCatch(
            expr = { do.call(caret::train, arg.list) },
            error = function(e) { NA }))
      result
    }
    tCtrl <-
      caret::trainControl(
        method = 'cv',
        number = k,
        p = split,
        sampling = 'down')
    results <- vector(mode = 'list', length = length(models))
    if(show_progress) { pb <- utils::txtProgressBar(max = length(models), style = 3) }
    for(i in 1:length(models)) {
      if(show_progress) { utils::setTxtProgressBar(pb, i) }
      then <- Sys.time()
      fit <- train_safe(formula, data, tCtrl, models[i])
      attr(fit, 'model') <- models[i]
      attr(fit, 'time') <- as.double(difftime(Sys.time(), then, units = "secs"))
      results[[i]] <- fit
    }
    if(show_progress) { close(pb); rm(pb) }
    results
  }
