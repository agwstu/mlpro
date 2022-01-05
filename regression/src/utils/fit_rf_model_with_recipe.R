fit_rf_model_with_recipe <- function(recipe, data){
  rf_model <- rand_forest()

  rf_wflow <-
    workflow() %>%
      add_model(rf_model) %>%
      add_recipe(recipe)

  rf_fit <- fit(rf_wflow,
                data)

  return (rf_fit)
}