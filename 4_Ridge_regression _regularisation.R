set.seed ( seed )
design <- layer_input ( shape = c( ncol(X_train)), dtype = 'float32', name = 'design')
output = design %>%
layer_dense ( units =20 , kernel_regularizer = regularizer_l2 (0.00001),activation ='tanh', name ='layer1') %>%
layer_dense ( units =15 , kernel_regularizer = regularizer_l2 (0.00001),activation ='tanh', name ='layer2') %>%
layer_dense ( units =10 , kernel_regularizer = regularizer_l2 (0.00001),activation ='tanh', name ='layer3') %>%
layer_dense ( units =1, activation ='exponential', name ='output')
#summary(output)
#summary(design)
model <- keras_model ( inputs = c( design ), outputs = c( output ))
model %>% compile (loss = 'poisson',optimizer ='sgd')
fit <- model %>% fit(X_train , Y_train , epochs =100 , batch_size =10000)
 