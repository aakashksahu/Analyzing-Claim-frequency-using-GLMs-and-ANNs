library(CASdatasets)

data("freMTPL2freq")  


 attach(freMTPL2freq)

##########**********Encoding vehpower**********##########

library(caret)
library(utils)
library(mltools)
library(data.table)
library(caTools)

temp_VehPower <- as.data.frame(VehPower)
preproc_VehPower <- preProcess(temp_VehPower,method=c("range"))
enc_VehPower <- predict(preproc_VehPower,temp_VehPower)
summary(enc_VehPower)
remove(temp_VehPower,preproc_VehPower)
lambda <- sum(ClaimNb)/sum(Exposure)

###########**********Encoding VehAge**********##########

temp_VehAge <- VehAge
temp_VehAge[temp_VehAge>20] < - 20
temp_VehAge <- as.data.frame(temp_VehAge)
preproc_VehAge<- preProcess(temp_VehAge , method = c("range"))
enc_VehAge <- predict(preproc_VehAge , temp_VehAge)
summary(enc_VehAge)
names(enc_VehAge) <- "VehAge"
remove(temp_VehAge,preproc_VehAge)

##########**********Encoding DrivAge**********##########

temp_DrivAge <- DrivAge
temp_DrivAge[temp_DrivAge>90] <- 90
temp_DrivAge<- as.data.frame(temp_DrivAge)
preproc_DrivAge <- preProcess(temp_DrivAge , method=c("range"))
enc_DrivAge <- predict(preproc_DrivAge, temp_DrivAge)
summary(enc_DrivAge)
names(enc_DrivAge) <- "DrivAge"
remove(temp_DrivAge,preproc_DrivAge)

##########**********Encoding BonusMalus**********##########

temp_BonusMalus <- BonusMalus

temp_BonusMalus[temp_BonusMalus > 150] <- 150
temp_BonusMalus <- as.data.frame(temp_BonusMalus)
preproc_BonusMalus <- preProcess(temp_BonusMalus , method=c("range"))
enc_BonusMalus<- predict(preproc_BonusMalus,temp_BonusMalus)
summary(enc_BonusMalus)
names(enc_BonusMalus) <- "BonusMalus"
remove(temp_BonusMalus,preproc_BonusMalus)

##########**********Encoding Density**********##########

temp_Density <- log(Density)
temp_Density <- as.data.frame(temp_Density)
preproc_Density <- preProcess(temp_Density,method = c("range"))
enc_Density <- predict(preproc_Density , temp_Density)
summary(enc_Density)
names(enc_Density) <- "Density"
remove(temp_Density,preproc_Density)

##########**********Encoding Area**********##########

temp_Area <- as.numeric(Area)
temp_Area <- as.data.frame(temp_Area)
preproc_Area <- preProcess(temp_Area,method=c("range"))
enc_Area <- predict(preproc_Area , temp_Area)
summary(enc_Area)
names(enc_Area) <- "Area"
remove(temp_Area,preproc_Area) 

##########**********Encoding VehGas**********##########
### Assigning 1/2 to Regular and -1/2 to Diesel


enc_VehGas <- rep(0,length(VehGas))
enc_VehGas[VehGas=="Regular"] <- 1/2
enc_VehGas[VehGas=="Diesel"] <- -1/2
enc_VehGas<- as.data.frame(enc_VehGas)
names(enc_VehGas) <- "VehGas"



##########********** Encoding VehBrand**********##########

enc_VehBrand <- one_hot(as.data.table(VehBrand))


##########********** Encoding Region **********##########

enc_Region <- one_hot(as.data.table(Region))



##########********** Dividing the data into train and test **********##########

temp_ClaimNb <- as.data.frame(ClaimNb)
enc_ClaimNb <- temp_ClaimNb[,2]
enc_ClaimNb <- as.data.frame(enc_ClaimNb)
names(enc_ClaimNb) <- "ClaimNb"
remove(temp_ClaimNb)
enc_data <- as.data.frame(cbind(enc_VehPower,enc_VehAge,enc_DrivAge,enc_BonusMalus,enc_VehBrand,enc_VehGas,enc_Area,enc_Density,enc_Region,enc_ClaimNb))
temp <- enc_data
enc_data <- as.matrix(enc_data)
dimnames(enc_data) <- NULL
#set.seed(123)

set.seed (100)

ll <- sample (c (1: nrow (enc_data)), round (0.9* nrow ( enc_data )), replace = FALSE )
#learn <- enc_data[ll ,]
#test <- enc_data[-ll ,]
#sample = sample.split(enc_data,SplitRatio = 0.9)
#samp_size <- floor(0.90*nrow(enc_data))
#train_ind <- sample(seq_len(nrow(enc_data)),size = samp_size)

data_train <- enc_data[ll,]
data_test <-  enc_data[-ll,]
X_train <- data_train[,1:39]
Y_train <- data_train[,40]
X_test <- data_test[,1:39]
Y_test <- data_test[,40]



