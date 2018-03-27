#Read the data
antyodayadata<- read.csv("MIGRATED_DATA_WITH_RANK.csv",stringsAsFactors= FALSE)

# Take the subset
antyodayadata<- antyodayadata[c(1,4:18,27:29,34:35,38,80,81)]

#Range of Latitude and Longitude of India
antyodayadata<- subset(antyodayadata, (village_latitude>8.0666667 & village_latitude<37.1)& (village_longitude>68.1166666 & village_longitude<97.4166666))

# Pass the lat and long to a dataframe with other options
df<- data.frame(lat= antyodayadata$village_latitude, lng =antyodayadata$village_longitude,popup= paste(antyodayadata$village_name_lgd
                                                                                                       ,"</br>",antyodayadata$village_pin_code,"</br>",antyodayadata$GP.Name,"</br>",antyodayadata$Block.Name,"</br>",antyodayadata$District.Name,"</br>",antyodayadata$State.Name)
                ,durationelec= antyodayadata$availablility_hours_of_domestic_electricity
                ,disbank=antyodayadata$distance_of_banks
                ,isbank=antyodayadata$is_bank_available
                ,distrans=antyodayadata$distance_of_public_transport
                ,istrans=antyodayadata$availability_of_public_transport
                ,population = antyodayadata$total_population
                ,state=antyodayadata$State.Name
                ,ID = seq.int(nrow(antyodayadata)))

m <- list(
        l = 50,
        r = 50,
        b = 100,
        t = 100,
        pad = 4
)