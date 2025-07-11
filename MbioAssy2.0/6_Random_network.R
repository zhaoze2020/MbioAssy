###@author: Feng Ju
###@email: jufeng@westlake.edu.cn
###@cite Ju F, Xia Y, Guo F, Wang ZP, Zhang T. 2014. 
###@Taxonomic relatedness shapes bacterial assembly in activated sludge of globally distributed wastewater treatment plants.
###@Environmental Microbiology. 16(8):2421-2432

library(igraph)

#set the size of random network
n=2194   #number of nodes
e=44680  #number of edges
  
#generate 1000 random networks
for (i in 1:1000) {
  g <- erdos.renyi.game(n, e,'gnm')
  
  # Global toplogical features
  c <- cluster_walktrap(g)
  md <- modularity(g, membership(c), weights = NULL)
  cc <- transitivity(g, vids = NULL,
                     weights = NULL)
  spl <- average.path.length(g, directed=FALSE, unconnected=TRUE)
  gd  <- graph.density(g, loops=FALSE)
  nd  <- diameter(g, directed = FALSE, unconnected = TRUE, weights = NULL)
  
  ND <- degree(g, v = V(g), mode="all")
  ad  <- mean(node.degree)
  
  global.topol <- data.frame(n,e,cc,spl,md,gd,nd,ad)
  
  write.table(global.topol, file = sprintf("N%dE%d.er.random.network.xls",n,e), 
              append = TRUE, sep = "\t",row.names = FALSE, col.names = TRUE) }

# print node distribution statistics

degree <- data.frame(table(degree=factor(ND, levels=seq_len(max(ND)))))
plot(degree)
