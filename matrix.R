platform<-platform_year$Platform
platform<-unique(platform)
length(platform)
A<-matrix(NA,nrow=37,ncol=31)
df<-as.data.frame(A)
colnames(df)<-platform
rownames(df)<-unique(platform_year$Year)
for(i in 1:length(rownames(df))){
  for(j in 1:length(colnames(df))){
    if(length(platform_year$Revenue[platform_year$Year==rownames(df)[i]&platform_year$Platform==colnames(df)[j]])!=0){
      df[rownames(df)[i],colnames(df)[j]]<-platform_year$Revenue[platform_year$Year==rownames(df)[i]&platform_year$Platform==colnames(df)[j]]
    }
    else{df[rownames(df)[i],colnames(df)[j]]<-NA}
  }
}

