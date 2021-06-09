install_train_all_packages <-
  function(
    models = c('null', 'glm', 'rf', 'ctree', 'cforest', 'pls', 'gbm', 'pda', 'svmLinear', 'svmRadial', 'nb', 'tan', 'awtan', 'fda', 'knn', 'evtree', 'xgbDART', 'xgbLinear', 'xgbTree'),
    show_progress = interactive()) {
    if(show_progress) { pb <- utils::txtProgressBar(max = length(models), style = 3) }
    for(i in 1:length(models)) {
      if(show_progress) { utils::setTxtProgressBar(pb, i) }
      mi <- caret::getModelInfo(models[i], regex = F)
      if(is.null(mi[[1]])) {
        warning(paste0(models[i], ' is not known to caret'))
      } else if(!('Classification' %in% mi[[1]]$type)) {
        warning(paste0(models[i], ' can not be used for Classification'))
      } else if(!is.null(mi[[1]]$library)) {
        indx <- !(mi[[1]]$library %in% installed.packages())
        install.packages(mi[[1]]$library[indx], quiet = T)
      }
    }
    if(show_progress) { close(pb); rm(pb) }
  }