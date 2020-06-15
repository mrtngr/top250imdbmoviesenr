#combinar todos los datos
library(dplyr)

movies_imdb <- data_frame(Title=imdb_title, Year=imdb_year, Rating=imdb_rating,
                          Runtime=imdb_runtime, Metascore=imdb_metascore, Genre=imdb_genre,
                          Director=imdb_director, Actor=imdb_actor, Votes=imdb_votes)

top_genres <- movies_imdb%>%
    group_by(Genre)%>%
    summarize(n=n())

genres_plot <- ggplot(top_genres,aes(x=reorder(Genre,-n),y=n)) 

genres_plot + geom_bar(stat="identity", fill="steelblue") + labs(title="Distribución de género de las mejores 250 películas en IMDB. (2015-2020)",x="Género",y="Cantidad")

top10_movies_by_year <- movies_imdb%>%
  group_by(Year)%>%
  top_n(10,Rating)%>%
  arrange(desc(Year))

met_vs_rat_plot <- ggplot(movies_imdb, aes(Rating,Metascore))

met_vs_rat_plot + geom_jitter() + geom_smooth(method = lm, se = FALSE)

runtime_vs_rating <- ggplot(movies_imdb,aes(Runtime,Rating, color=Genre))

runtime_vs_rating + geom_jitter()    




    