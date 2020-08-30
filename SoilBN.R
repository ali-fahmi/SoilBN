library(bnlearn)

dag = model2network("[SoilTexture][SoilOrganicCarbon][MaxSpectrum|SoilTexture:SoilOrganicCarbon][MinSpectrum|SoilTexture:SoilOrganicCarbon][Se|SoilTexture:SoilOrganicCarbon][Zn|SoilTexture:SoilOrganicCarbon][Ca|SoilTexture:SoilOrganicCarbon][K|SoilTexture:SoilOrganicCarbon][N|SoilTexture:SoilOrganicCarbon][P|SoilTexture:SoilOrganicCarbon][Fe|SoilTexture:SoilOrganicCarbon][PH|Ca:K][Room][Bench][Fertiliser][AvailableZn|SoilTexture:SoilOrganicCarbon:Room:Bench:Fertiliser][AvailableCa|SoilTexture:SoilOrganicCarbon:Room:Bench:Fertiliser][AvailableK|SoilTexture:SoilOrganicCarbon:Room:Bench:Fertiliser][AvailableP|SoilTexture:SoilOrganicCarbon:Room:Bench:Fertiliser][AvailableFe|SoilTexture:SoilOrganicCarbon:Room:Bench:Fertiliser][Straw|AvailableZn:AvailableCa:AvailableK:AvailableP:AvailableFe]")
arc.set = matrix(c("SoilOrganicCarbon","MaxSpectrum",
                   "SoilTexture","MaxSpectrum",
                   "SoilOrganicCarbon","MinSpectrum",
                   "SoilTexture","MinSpectrum",
                   "SoilOrganicCarbon","Fe",
                   "SoilTexture","Fe",
                   "SoilOrganicCarbon","K",
                   "SoilTexture","K",
                   "SoilOrganicCarbon","Ca",
                   "SoilTexture","Ca",
                   "SoilOrganicCarbon","Zn",
                   "SoilTexture","Zn",
                   "SoilOrganicCarbon","Se",
                   "SoilTexture","Se",
                   "SoilOrganicCarbon","P",
                   "SoilTexture","P",
                   "SoilOrganicCarbon","N",
                   "SoilTexture","N",
                   "Ca","PH",
                   "K","PH",
                   "SoilOrganicCarbon","AvailableZn",
                   "SoilTexture","AvailableZn",
                   "Room","AvailableZn",
                   "Bench","AvailableZn",
                   "Fertiliser","AvailableZn",
                   "SoilOrganicCarbon","AvailableP",
                   "SoilTexture","AvailableP",
                   "Room","AvailableP",
                   "Bench","AvailableP",
                   "Fertiliser","AvailableP",
                   "SoilOrganicCarbon","AvailableK",
                   "SoilTexture","AvailableK",
                   "Room","AvailableK",
                   "Bench","AvailableK",
                   "Fertiliser","AvailableK",
                   "SoilOrganicCarbon","AvailableFe",
                   "SoilTexture","AvailableFe",
                   "Room","AvailableFe",
                   "Bench","AvailableFe",
                   "Fertiliser","AvailableFe",
                   "SoilOrganicCarbon","AvailableCa",
                   "SoilTexture","AvailableCa",
                   "Room","AvailableCa",
                   "Bench","AvailableCa",
                   "Fertiliser","AvailableCa",
                   "AvailableFe","Straw",
                   "AvailableZn","Straw",
                   "AvailableCa","Straw",
                   "AvailableP","Straw",
                   "AvailableK","Straw"),
                 byrow = TRUE, ncol = 2,
                 dimnames = list(NULL, c("from", "to")))
dag = empty.graph(c("SoilOrganicCarbon", "SoilTexture", "MaxSpectrum", "MinSpectrum", "Fe", "Se", "Zn", "Ca", "N", "P", "K", "PH", "Room", "Bench", "Fertiliser", "AvailableZn", "AvailableP", "AvailableK", "AvailableFe", "AvailableCa", "Straw"))
arcs(dag) = arc.set
par(mar = rep(2, 4))
png("dag.png")
graphviz.plot(dag)
dev.off()

FN="Random data.csv"
h=TRUE
data = read.csv(file=FN, head=h, sep=",")
data$SoilTexture = as.factor(data$SoilTexture)
data$SoilOrganicCarbon = as.factor(data$SoilOrganicCarbon)
data$Room = as.factor(data$Room)
data$Bench = as.factor(data$Bench)
data$Fertiliser = as.factor(data$Fertiliser)
data$AvailableZn = as.numeric(data$AvailableZn)
data$AvailableP = as.numeric(data$AvailableP)
data$AvailableK = as.numeric(data$AvailableK)
data$AvailableFe = as.numeric(data$AvailableFe)
data$AvailableCa = as.numeric(data$AvailableCa)
data$Straw = as.numeric(data$Straw)
data$PH = as.numeric(data$PH)
fitted = bn.fit(dag,data)
