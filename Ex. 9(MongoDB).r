install.packages("mongolite")
install.packages("tidyverse", dependencies=T)
install.packages("lubridate") 
install.packages("ggplot2")

library(mongolite)
connection_string = 'mongodb://localhost:27017'
trips_collection = mongo(collection="trips", db="sample_training", url=connection_string)
trips_collection$count()
trips_collection$iterate()$one()
user_types = trips_collection$aggregate('[{"$group":{"_id":"$usertype", "Count": {"$sum":1}}}]')
df <- as.data.frame(user_types)

library(tidyverse)
library(lubridate)
library(ggplot2)

ggplot(df,aes(x=reorder(`_id`,Count),y=Count))+ geom_bar(stat="identity",color='yellow',fill='#FFC300')+geom_text(aes(label = Count), color = "red") +coord_flip()+xlab("User Type")
head(df)