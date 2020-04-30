library(cluster)
library(factoextra)
library(cluster.datasets)
library(xlsx)
library(ggbiplot)
library(ggplot2)

hahahacopy <- read_excel("D:/Project (Non Graphic Design)/Data Mining Projext/National Data Day/hahaha - Copy.xlsx")

#Import dataset
df <- scale(Book3)

#Bentuk sebaran dataset
hist(hahaha$ketimun, main = "Sebaran Ketimun", xlab = "Produktivitas Ketimun (Ton/Ha)")
hist(hahaha$`bawang merah`, main = "Sebaran Bawang Merah", xlab = "Produktivitas Bawang Merah (Ton/Ha)")
hist(hahaha$`kacang panjang`, main = "Sebaran Kacang Panjang", xlab = "Produktivitas Kacang Panjang (Ton/Ha)")

#Hopkins Statistics
res <- get_clust_tendency(df, n = nrow(df) - 1, graph = TRUE)
res$hopkins_stat
res$plot
rownames(df) <- c("Kab. Banjarnegara","Kab. Banyumas","Kab. Batang","Kab. Blora","Kab. Boyolali","Kab. Brebes","Kab. Cilacap","Kab. Demak","Kab. Grobogan","Kab. Jepara","Kab. Karanganyar","Kab. Kebumen","Kab. Kendal","Kab. Klaten","Kab. Kudus","Kab. Magelang","Kab. Pati","Kab. Pekalongan","Kab. Pemalang","Kab. Purbalingga","Kab. Purworejo","Kab. Rembang","Kab. Semarang","Kab. Sragen","Kab. Sukoharjo","Kab. Tegal","Kab. Temanggung","Kab. Wonogiri","Kab. Wonosobo","Kota Magelang","Kota Pekalongan","Kota Salatiga","Kota Semarang","Kota Surakarta","Kota Tegal")

#Dissimilarity Matrix
df.eucl <- dist(df, method = "euclidean")
fviz_dist(df.eucl)
round(as.matrix(df.eucl)[1:3, 1:3], 1)

pr.pca <- prcomp(df, center = TRUE)
ggbiplot(pr.pca)

#tentuin jumlah k optimal
fviz_nbclust(df, pam, method = "silhouette") 

#Proses Clustering
pam.res = pam(df, 4, metric = "euclidean")
pam.res$medoids # Medoid yang digunakan
print(pam.res)
fviz_cluster(pam.res, 
             palette = c("#FF0000", "#3e0e35","#45de88","#0077ff","#00FFFF"), # color palette
             ellipse.type = "t", # Concentration ellipse
             repel = TRUE, # Avoid label overplotting (slow)
             ggtheme = theme_classic()
)
si = silhouette(4,pam.res)
windows()
plot(si)
write.xlsx(pam.res$clustering, "D:/Project (Non Graphic Design)/Data Mining Projext/National Data Day/cluster.xlsx",sheetName = "hasil_akhir.xlsx",row.names = TRUE, col.names = TRUE)
# new_dataset1 <- cbind(jateng, df, cluster = pam.res$cluster)




library(corrplot)
res <- cor(df)
round(res, 2)
corrplot(res, tl.col = "black", tl.srt = 45, method="circle")
 boxplot(res)
 
# Penentuan Nilai Cluster
medoid <- as.data.frame(dedlen)
d_med <- c("Kab. Pekalongan","Kab. Grobogan","Kab. Temanggung","Kota Magelang")
rownames(medoid) <- c("Kab. Pekalongan","Kab. Grobogan","Kab. Temanggung","Kota Magelang")
medoid

barplot(medoid$Rata, col=c("#FF0000", "#3e0e35","#45de88","#0077ff"), ylim=c(0,10), main = "Produktivitas Rata-Rata pada Medoid Cluster (scaled)", xlab="Cluster", ylab="Produktivitas", legend = rownames(medoid),beside = TRUE) + abline(0,0)

        