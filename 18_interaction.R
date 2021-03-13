
## 1.interaction between VehPower and VehAge

library("keras")
seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model1 <- keras_model_sequential()
q1 <- 5
model1 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model1 )
model1 %>% compile (loss = 'poisson',optimizer ='sgd')
#x_learn <- subset(data_train,select = -c(ClaimNb))

fit <- model1 %>% fit(X_train[,c(1,2)] , Y_train , epochs =100 , batch_size =10000)

## 2.interaction between VehPower and DrivAge

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model2 <- keras_model_sequential()
q1 <- 5
model2 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model2 )
model2 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model2 %>% fit(X_train[,c(1,3)] , Y_train , epochs =100 , batch_size =10000)


## 3.interaction between VehPower and BonusMalus

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model3 <- keras_model_sequential()
q1 <- 5
model3 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model3 )
model3 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model3 %>% fit(X_train[,c(1,4)] , Y_train , epochs =100 , batch_size =10000)



## 4.interaction between VehPower and VehBrand

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model4 <- keras_model_sequential()
q1 <- 5
model4 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(12)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model4 )
model4 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model4 %>% fit(X_train[,c(1,5,6,7,8,9,10,11,12,13,14,15)] , Y_train , epochs =100 , batch_size =10000)



## 5.interaction between VehPower and VehGas

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model5 <- keras_model_sequential()
q1 <- 5
model5 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model5 )
model5 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model5 %>% fit(X_train[,c(1,16)] , Y_train , epochs =100 , batch_size =10000)


## 6.interaction between VehPower and Area

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model6 <- keras_model_sequential()
q1 <- 5
model6 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model6 )
model6 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model6 %>% fit(X_train[,c(1,17)] , Y_train , epochs =100 , batch_size =10000)



## 7.interaction between VehPower and Density

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model7 <- keras_model_sequential()
q1 <- 5
model7 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(2)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model7 )
model7 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model7 %>% fit(X_train[,c(1,18)] , Y_train , epochs =100 , batch_size =10000)

 
## 8.interaction between VehPower and Density

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model8 <- keras_model_sequential()
q1 <- 5
model8 %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(22)) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model8 )
model8 %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model8 %>% fit(X_train[,c(1,19:39)] , Y_train , epochs =100 , batch_size =10000)


