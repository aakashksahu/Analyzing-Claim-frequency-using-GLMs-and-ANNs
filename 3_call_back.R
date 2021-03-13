set.seed ( seed )
#use_session_with_seed ( seed )

design <- layer_input ( shape = c( ncol(X_train)), dtype = 'float32', name = 'design')

output = design %>%
  layer_dense ( units =20 , activation ='tanh', name ='layer1') %>%
  layer_dense ( units =15 , activation ='tanh', name ='layer2') %>%
  layer_dense ( units =10 , activation ='tanh', name ='layer3') %>%
  layer_dense ( units =1, activation ='exponential', name ='output')

model <- keras_model ( inputs = c( design ), outputs = c( output ))
model %>% compile ( loss = 'poisson', optimizer = 'nadam')
CBs <- callback_model_checkpoint ("path0", monitor = "val_loss",save_best_only = TRUE , save_weights_only = TRUE )

fit <- model %>% fit ( X_train , Y_train , epochs =1000 , batch_size =5000,validation_split =.2 , callbacks = CBs )

load_model_weights_hdf5 (model , "path0")


