library(httr)
library(tidyverse)

req <- GET("api.henleypassportindex.com/api/v3/countries")

parsed <- req$content |> 
  rawToChar() |> 
  fromJSON()

parsed$countries |> names()

parsed$countries |> View()
  

unnested_data <- parsed$countries |> 
  filter(has_data) |> 
  tidyr::unnest_longer(col = data) |>
  select(code, country, region, data, year = data_id) |> 
  unnest_wider(col = data)


req2 <- GET("api.henleypassportindex.com/api/v3/visa-single/US")

parsed2 <- req2$content |> 
  rawToChar() |> 
  fromJSON()

parsed2$visa_on_arrival


