# dataset link : https://s3.amazonaws.com/tripdata/index.html ;  download first one
# install mongodb from https://www.mongodb.com/try/download/community . while installing click complete, next, tick Install mongo compass, next, install
# Windows seach "services" select mongo server, right click on start
# Find connection_string(line 14) by opening mongoDB compass and copy paste the URI
# click connect; under database tab create database; database name = sample_training; collection = "trips"
# click on newly created databse; click on created collection; import data; select the downloaded data set in CSV format; import; run remaning comands

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
