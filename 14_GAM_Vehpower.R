library ( plyr )
library ( mgcv )
learn <- main_learn
#VolGLM <- learn$fit_GLM1*learn$Exposure

# data compression of the learning data set
#learn.GAM1 <- ddply (learn , .( VehPower ), summarize , VolGLM = sum ( VolGLM ), ClaimNb = sum ( ClaimNb ))
#learn.GAM1 <- ddply (learn , .( VehPower ), summarize , ClaimNb = sum ( ClaimNb ))
# GAM fitting
GAM1 <- gam ( ClaimNb ~ s( VehPower , bs ="cr"), data = learn , method ="GCV.Cp",
                family = poisson )
summary (GAM1)
learn$fit_GAM1 <- predict(GAM1,newdata = learn, type = "response" )

test$fit_GAM1 <- predict (GAM1 , newdata = test , type ="response")

(in_sample_GAM1 <- 2*( sum ( learn$fit_GAM1 )- sum ( learn$ClaimNb )
                       + sum ( log (( learn$ClaimNb / learn$fit_GAM1 )^( learn$ClaimNb )))))

(average_in_sample_GAM1 <- in_sample_GAM1 / nrow ( learn ))

(out_of_sample_GAM1 <- 2*( sum( test$fit_GAM1 )- sum(test$ClaimNb)+
                             sum( log (( test$ClaimNb / test$fit_GAM1 )^( test$ClaimNb )))))

(average_out_of_sample_GAM1 <- out_of_sample_GAM1 / nrow ( test ))
main_learn <- learn
(Avg_MSE_train_GAM1 <- (sum((learn$fit_GAM1-learn$ClaimNb)^2))/nrow(learn))
(Avg_MSE_test_GAM1 <- (sum((test$fit_GAM1-test$ClaimNb)^2))/nrow(test))

