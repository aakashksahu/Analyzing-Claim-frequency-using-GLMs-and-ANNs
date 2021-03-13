# encoding this data for CANN approach

library(CASdatasets)
set.seed (100)
data("freMTPL2freq")  
attach(freMTPL2freq)
data <- freMTPL2freq

data$AreaGLM <- as.integer ( data$Area )
data$VehPowerGLM <- as.factor ( pmin ( data$VehPower ,9))
VehAgeGLM <- cbind (c (0:110) , c(1, rep (2 ,10) , rep (3 ,100)))
data$VehAgeGLM <- as.factor ( VehAgeGLM [ data$VehAge +1 ,2])
data [,"VehAgeGLM"] <- relevel ( data [,"VehAgeGLM"], ref ="2")
DrivAgeGLM <- cbind(c(18:100) , c( rep (1 ,21 -18) , rep (2 ,26 -21) , rep (3 ,31 -26) , rep (4 ,41 -31),rep(5,51 -41),rep(6, 71 -51),rep(7,101 -71)))
data$DrivAgeGLM <- as.factor( DrivAgeGLM [ data$DrivAge -17 ,2])
data [," DrivAgeGLM "] <- relevel( data [,"DrivAgeGLM"], ref ="5")
data$BonusMalusGLM <- as.integer( pmin ( data$BonusMalus , 150))
data$DensityGLM <- as.numeric( log (data$Density ))
data [,"Region"] <- relevel( data [,"Region"], ref ="Alsace")
lambda.hom <- sum(data$ClaimNb)/sum(data$Exposure)
data <- data[,-17]
set.seed (100)
ll <- sample (c (1: nrow ( data )), round (0.9* nrow ( data )), replace = FALSE )
learn <- data[ll ,]
test <- data[-ll ,]
main_learn <- learn 
main_test <- test
GLM_1 <- glm ( formula = ClaimNb ~ VehPowerGLM + VehAgeGLM + DrivAgeGLM +
         BonusMalusGLM + VehBrand + VehGas + DensityGLM + Region +
         AreaGLM , family = poisson (), data = learn , offset = log ( Exposure ))

learn$fit_GLM1 <- fitted(GLM_1 )
test$fit_GLM1 <- predict (GLM_1 , newdata = test , type ="response")
(in_sample_GLM1 <- 2*( sum ( learn$fit_GLM1 )- sum ( learn$ClaimNb )
  + sum ( log (( learn$ClaimNb / learn$fit_GLM1 )^( learn$ClaimNb )))))

(average_in_sample_GLM1 <- in_sample_GLM1 / nrow ( learn ))

(out_of_sample_GLM1 <- 2*( sum( test$fit_GLM1 )- sum(test$ClaimNb)+
                sum( log (( test$ClaimNb / test$fit_GLM1 )^( test$ClaimNb )))))

(average_out_of_sample_GLM1 <- out_of_sample_GLM1 / nrow ( test ))



GLM_2 <- glm ( formula = ClaimNb ~ AreaGLM + VehPowerGLM + VehAgeGLM + BonusMalusGLM +
         VehBrand + VehGas + DensityGLM + Region +
         DrivAge + log ( DrivAge ) + I( DrivAge ^2) + I( DrivAge ^3) + I( DrivAge ^4) ,
         family = poisson (), data = learn , offset = log( Exposure ))
learn$fit_GLM2 <- fitted(GLM_2 )
test$fit_GLM2 <- predict (GLM_2 , newdata = test , type ="response")

(in_sample_GLM2 <- 2*( sum ( learn$fit_GLM2 )- sum ( learn$ClaimNb )
                  + sum ( log (( learn$ClaimNb / learn$fit_GLM2 )^( learn$ClaimNb )))))

(average_in_sample_GLM2 <- in_sample_GLM2 / nrow ( learn ))
(out_of_sample_GLM2 <- 2*( sum( test$fit_GLM2 )- sum(test$ClaimNb)+
                            sum( log (( test$ClaimNb / test$fit_GLM2 )^( test$ClaimNb )))))

(average_out_of_sample_GLM2 <- out_of_sample_GLM2 / nrow ( test ))
main_learn <- learn
#####


(out_of_sample_1 <- 2*( sum( test$ANN.with.GLM )- sum(test$ClaimNb)+
                             sum( log (( test$ClaimNb / test$ANN.with.GLM )^( test$ClaimNb )))))

(average_out_of_sample_1 <- out_of_sample_1 / nrow ( test ))

######

(out_of_sample_2 <- 2*( sum( test$Only.ANN )- sum(test$ClaimNb)+
                          sum( log (( test$ClaimNb / test$Only.ANN )^( test$ClaimNb )))))

(average_out_of_sample_2 <- out_of_sample_2 / nrow ( test ))


(Avg_MSE_train_GLM1 <- (sum((learn$fit_GLM1-learn$ClaimNb)^2))/nrow(learn))
(Avg_MSE_test_GLM1 <- (sum((test$fit_GLM1-test$ClaimNb)^2))/nrow(test))

(Avg_MSE_train_GLM2 <- (sum((learn$fit_GLM2-learn$ClaimNb)^2))/nrow(learn))
(Avg_MSE_test_GLM2 <- (sum((test$fit_GLM2-test$ClaimNb)^2))/nrow(test))
