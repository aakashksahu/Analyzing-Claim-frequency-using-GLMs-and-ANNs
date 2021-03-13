library(keras)

seed <- 123
set.seed(seed)
#use_session_with_seed(seed)
model <- keras_model_sequential()
q1 <- 20
model %>% 
  layer_dense ( units = q1 , activation = 'tanh', input_shape = c(ncol(X_train))) %>%
  layer_dense ( units = 1, activation = 'exponential')
summary ( model )
model %>% compile (loss = 'poisson',optimizer ='sgd')
#x_learn <- subset(data_train,select = -c(ClaimNb))

fit <- model %>% fit(X_train , Y_train , epochs =100 , batch_size =10000)


########## initializing the weights to zero ##########

#model %>%
 # layer_dense ( units = q1 , activation = 'tanh', input_shape = c( nrow ( data_train ))) %>%
  #layer_dense ( units = 1, activation = 'exponential',weights = list(array(0, dim =c(q1 ,1)) , array(log(lambda), dim=c(1))))

#a <- model %>% evaluate(X_test, Y_test)
