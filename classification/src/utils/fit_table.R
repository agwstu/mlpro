fit_table <- function(data){
  data %>%
    head() %>%
    kbl() %>%
    kable_paper() %>%
    scroll_box(width = "100%")
}