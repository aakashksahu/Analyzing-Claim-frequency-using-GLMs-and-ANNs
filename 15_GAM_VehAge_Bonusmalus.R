library ( plyr )
library ( mgcv )
learn <- main_learn
#VolGLM <- learn$fit_GLM2*learn$Exposure
# data compression of the learning data set

#learn.GAM2 <- ddply (learn , .( VehAge , BonusMalus ), summarize , VolGLM = sum( VolGLM ),
                      #ClaimNb =sum( ClaimNb ))

# Model GAM fitting
GAM2 <- gam( ClaimNb ~ s( VehAge , bs ="cr") + s( BonusMalus , bs ="cr"), data = learn,
            method ="GCV.Cp", family = poisson )
learn$fit_GAM2 <- predict(GAM2,newdata = learn, type = "response" )
test$fit_GAM2 <- predict (GAM2 , newdata = test , type ="response")

(in_sample_GAM2 <- 2*( sum ( learn$fit_GAM2 )- sum ( learn$ClaimNb )
                       + sum ( log (( learn$ClaimNb / learn$fit_GAM2 )^( learn$ClaimNb )))))

(average_in_sample_GAM2 <- in_sample_GAM1 / nrow ( learn ))

(out_of_sample_GAM2 <- 2*( sum( test$fit_GAM2 )- sum(test$ClaimNb)+
                             sum( log (( test$ClaimNb / test$fit_GAM2 )^( test$ClaimNb )))))

(average_out_of_sample_GAM2 <- out_of_sample_GAM2 / nrow ( test ))
(Avg_MSE_train_GAM2 <- (sum((learn$fit_GAM2-learn$ClaimNb)^2))/nrow(learn))
(Avg_MSE_test_GAM2 <- (sum((test$fit_GAM2-test$ClaimNb)^2))/nrow(test))
