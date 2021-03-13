Design <- layer_input ( shape = c(7) , dtype = 'float32', name = 'Design')
VehBrand <- layer_input ( shape = c(1) , dtype = 'int32', name = 'VehBrand')
Region <- layer_input ( shape = c(1) , dtype = 'int32', name = 'Region')
LogVolGLM <- layer_input ( shape = c(1) , dtype = 'float32', name = 'LogVol')

BrEmb = VehBrand %>%
layer_embedding ( input_dim = 11, output_dim = d, input_length = 1, name = 'BrEmb') %>%
layer_flatten ( name ='Br_flat')

ReEmb = Region %>%
layer_embedding ( input_dim = 22, output_dim = d, input_length = 1, name = 'ReEmb') %>%
layer_flatten ( name ='Re_flat')

Network = list ( Design , BrEmb , ReEmb ) %>% layer_concatenate ( name ='concate') %>%
layer_dense ( units =20 , activation ='tanh', name ='hidden1') %>%
layer_dense ( units =15 , activation ='tanh', name ='hidden2') %>%
layer_dense ( units =10 , activation ='tanh', name ='hidden3') %>%
layer_dense ( units =1, activation ='linear', name ='Network',
              weights = list ( array (0, dim =c(10 ,1)) , array (log( lambda.hom ), dim=c (1))))

Response = list ( Network , LogVolGLM ) %>% layer_add ( name ='Add') %>%
layer_dense ( units =1, activation =k_exp , name = 'Response', trainable =FALSE ,
              weights = list ( array (1, dim =c(1 ,1)) , array (0, dim =c (1))))

model <- keras_model ( inputs = c( Design , VehBrand , Region , LogVolGLM ), outputs = c( Response ))

