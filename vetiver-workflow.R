library(vetiver)
library(tidymodels)
library(pins)
library(dplyr)


board <- board_folder(path = "board",versioned = TRUE)

car_mod <-
  workflow(mpg ~ ., linear_reg()) %>%
  fit(mtcars)

v <- vetiver_model(car_mod, "cars_lr",
                   metadata = list(toolkit="EDoN v2 toolkit",
                                   metrics=c(names(car_mod$fit$fit$fit$coefficients)),
                                   as.data.frame(car_mod$fit$fit$fit$coefficients)),
                   versioned = TRUE)
board %>% vetiver_pin_write(v)

r <- vetiver_model(car_mod, "cars_rf",
                   metadata = list(toolkit="EDoN v2 toolkit",
                                   metrics=c(names(car_mod$fit$fit$fit$coefficients)),
                                   as.data.frame(car_mod$fit$fit$fit$coefficients)),
                   versioned = TRUE)
board %>% vetiver_pin_write(r)