model <- keras_model_sequential()
model %>%
 layer_dense ( units = 20, activation = 'tanh', input_shape = c(39),name = 'layer1') %>%
 layer_batch_normalization() %>%
 layer_dropout ( rate = 0.05) %>%
 layer_dense ( units = 15, activation = 'tanh',name = 'layer2') %>%
 layer_batch_normalization() %>%
 layer_dropout ( rate = 0.05) %>%
 layer_dense ( units = 10, activation = 'tanh',name = 'layer3') %>%
 layer_dropout ( rate = 0.05) %>%
 layer_dense ( units = 1, activation = 'exponential')
model %>% compile (loss = 'poisson',optimizer ='sgd')

fit <- model %>% fit(X_train , Y_train , epochs =100 , batch_size =10000)
model %>% evaluate(X_test, Y_test)
