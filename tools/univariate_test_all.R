univariate_test_all <-
  function(data, target) {
    loop <- function(data, test, target, predictors) {
      if(length(predictors) == 0) {
        NULL
      } else {
        t1 <- lapply(predictors, function(x){ test(data, target, x) })
        t1 <- do.call(rbind, t1)
        t1[order(abs(t1$stat), decreasing  = T),]
      }
    }
    test_cont <- function(data, target, predictor) {
      t1 <- data[,c(target, predictor)]
      colnames(t1) <- c('target', 'value')
      t2 <- t.test(value ~ target, data = t1)
      t3 <- list(
        name = predictor,
        test = 't',
        stat = as.numeric(t2$statistic),
        df = as.numeric(t2$parameter),
        pv = t2$p.value)
      as.data.frame(t3)
    }
    test_cat <- function(data, target, predictor) {
      t1 <- data[,c(target, predictor)]
      colnames(t1) <- c('target', 'value')
      t1 <- xtabs(~ target + value, data = t1)
      t2 <- chisq.test(t1)
      t3 <- list(
        name = predictor,
        test = 'x2',
        stat = as.numeric(t2$statistic),
        df = as.numeric(t2$parameter),
        pv = t2$p.value)
      as.data.frame(t3)
    }
    cns <- colnames(data)
    cns <- cns[!(cns %in% target)]
    indx <- sapply(cns, function(x){is.factor(data[,x])})
    t1 <- loop(data, test_cont, target, cns[!indx])
    t2 <- loop(data, test_cat, target, cns[indx])
    rbind(t1, t2)
  }
