library("RJSONIO")
inputFile <- "data/TestInput_Global.json"
input <- fromJSON(paste(readLines(inputFile), collapse=""));
Rruntime = system.time(source("Global0.5Experiment.R"))
print(paste('Time to run:',Rruntime[3]))
output <- toJSON(output)
fileConn<-file("data/output_Global.json")
writeLines(output, fileConn)
close(fileConn)
