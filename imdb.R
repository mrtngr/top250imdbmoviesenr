##install.packages("rvest") paquete para realizar web-scraping

library(rvest)
library(ggplot2)
library(dplyr)
library(stringr)

# url a página html con las mejores 250 peliculas de los últimos 5 años. 
url <- "https://www.imdb.com/search/title/?title_type=feature&release_date=2015-06-12,2020-06-12&num_votes=100000,&colors=color&languages=en&sort=user_rating,desc&count=250"

imdb <- html(url)

#dplyr para obtener el ranking de las peliculas
imdb_ranking <- imdb %>%
  html_nodes(".text-primary")%>%
  html_text()

imdb_ranking <- as.numeric((imdb_ranking))

#dplyr para obtener el titulo de las peliculas
imdb_title <- imdb %>%
  html_nodes(".lister-item-header a")%>%
  html_text()

#dplyr para obtener el año de una película
imdb_year <- imdb %>%
  html_nodes(".text-muted.unbold")%>%
  html_text()

imdb_year <- str_remove_all(imdb_year, "[(I)]") #quitar sem 1
imdb_year <- str_remove_all(imdb_year, "[(II)]") #quitar sem 2
imdb_year <- str_remove_all(imdb_year, "X") #quitar errores
imdb_year <- str_remove_all(imdb_year, " ") #quitar errores
imdb_year <- str_remove_all(imdb_year, "V") #quitar errores

#dplyr para obtener el rating de las peliculas
imdb_rating <- imdb %>%
  html_nodes(".ratings-imdb-rating strong")%>%
  html_text()

imdb_rating <- as.numeric(imdb_rating)

#dplyr para obtener la duración de una película
imdb_runtime <- imdb %>%
  html_nodes(".runtime")%>%
  html_text()

imdb_runtime <- gsub("min","",imdb_runtime) #quitar minutos
imdb_runtime <- as.numeric(imdb_runtime)

#dplyr para obtener el género de una película
imdb_genre <- imdb %>%
  html_nodes(".genre")%>%
  html_text()

imdb_genre <- gsub("\n","",imdb_genre) #quitar "\n"
imdb_genre <-gsub(",.*","",imdb_genre) #dejar solo el primer género
imdb_genre <-gsub(" ","",imdb_genre)
imdb_genre <- as.factor(imdb_genre) #dejar el género como factor

#dplyr para obtener el metascore de una película
imdb_metascore <- imdb %>%
  html_nodes(".metascore")%>%
  html_text()

imdb_metascore <- gsub(" ","",imdb_metascore) #quitar espacios extras
imdb_metascore <- as.numeric(imdb_metascore)

#dplyr para obtener el director de una película
imdb_director <- imdb %>%
  html_nodes(".text-muted+ p a:nth-child(1)")%>%
  html_text()

#dplyr para obtener el actor principal de una película
imdb_actor <- imdb %>%
  html_nodes(".lister-item-content .ghost+ a")%>%
  html_text()

#dplyr para obtener la cantidad de votos en imdb de una película
imdb_votes <- imdb %>%
  html_nodes(".sort-num_votes-visible span:nth-child(2)")%>%
  html_text()

imdb_votes <- gsub(",","",imdb_votes)
imdb_votes <- as.numeric(imdb_votes)



