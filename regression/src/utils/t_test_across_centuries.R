t_test_test_across_centuries <- function(data_with_target, var){
  XX_century <- data_with_target %>%
    filter(year < 2000) %>%
    pull({{var}})
  XXI_century <- data_with_target %>%
    filter(year >= 2000) %>%
    pull({{var}})
  var_test_res <- var.test(XX_century, XXI_century)
  if (var_test_res$p.value < 0.05){
    t.test(x = XX_century, y = XXI_century, conf.int = 0.95, var.equal = FALSE)
  } else{
    t.test(x = XX_century, y = XXI_century, conf.int = 0.95, var.equal = TRUE)
  }
}