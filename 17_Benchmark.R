cf <- sum(learn$ClaimNb)/sum(learn$Exposure) # claim frequency
learn$fit.cf <- cf*learn$Exposure
test$fit.cf <- cf*test$Exposure
PD <- function(pred, obs) {200*(sum(pred)-sum(obs)+sum(log((obs/pred)^(obs))))/length(pred)}
Benchmark.GLM2 <- function(txt, pred, obs) {
  index <- ((PD(pred, obs) - PD(test$fit.cf, test$ClaimNb)) / (PD(test$fitGLM_2, test$ClaimNb) - PD(test$fit.cf, test$ClaimNb))) * 100
  sprintf("GLM2-Improvement-Index (PD test) of %s: %.1f%%", txt, index) 
}


dat$ANN.with.GLM <- pmax(dat$ANN.with.GLM,0.0001)
dat$Only.ANN <- pmax(dat$Only.ANN,0.1)
Benchmark.GLM2("ANN with GLM", dat$ANN.with.GLM, test$ClaimNb)
Benchmark.GLM2("only ANN", dat$Only.ANN, test$ClaimNb)
