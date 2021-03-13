Design <- layer_input ( shape = c(40) , dtype = 'float32', name = 'Design')
LogVol <- layer_input ( shape = c(1) , dtype = 'float32', name = 'LogVol')

Network = Design %>%
    layer_dense ( units =20 , activation ='tanh', name ='hidden1') %>%
    layer_dense ( units =15 , activation ='tanh', name ='hidden2') %>%
    layer_dense ( units =10 , activation ='tanh', name ='hidden3') %>%
    layer_dense ( units =1, activation ='linear', name ='Network',
                   weights = list ( array (0, dim =c(10 ,1)) , array (log( lambda.hom ), dim=c(1))))

 Response = list ( Network , LogVol ) %>% layer_add ( name ='Add') %>%
 layer_dense ( units =1, activation =k_exp , name = 'Response', trainable =FALSE ,
                    weights = list ( array (1, dim =c(1 ,1)) , array (0, dim =c (1))))

 model <- keras_model ( inputs = c( Design , LogVol ), outputs = c( Response ))
 model %>% compile ( optimizer = optimizer_nadam (), loss = 'poisson')
summary(model) 
#x_train <- cbind(VehPower,VehAge,DrivAge,BonusMalus,)

#in <- cbind(learn$VehPowerGLM ,learn$VehAgeGLM , learn$DrivAgeGLM ,
#                     learn$BonusMalusGLM , learn$VehBrand , learn$learn$VehGas , learn$DensityGLM , learn$Region ,
 #                learn$AreaGLM)
#fit <- model %>% fit(x_train , learn$ClaimNb  , epochs =100 , batch_size =10000)
