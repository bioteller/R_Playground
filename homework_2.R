# 杨辉三角，循环

yanghui <- function(l){
  p=list(c(1),c(1,1))
  for (i in 3:l){
    tmp = c(1,1)
    for (j in 1:(i-2)){
      #print(j)
      tmp <- append(tmp,p[[i-1]][j]+p[[i-1]][j+1],after = j)
    }
    p[[i]] =  tmp
  }
  return(p)
}
yh_plot <- function(x){
  for (i in 1:length(x)){
    zw <- paste0(rep(" ",length(x)-i),collapse = "")
    yh1 <- paste(x[[i]],collapse = " ")
    yh2 <- sum(x[[i]])
    print(paste0(zw,yh1,zw,"  | sum:",yh2))
    
  }
}
gen_yh <- function(x){
  yh_plot(yanghui(x))
}

yanghui(6)
system.time(gen_yh(1))


##### y ####
y <- function(x){
  yh<-matrix(nrow = x+1 ,ncol = x+1 )
  yh[1,1]=1
  for(i in 1:nrow(yh)){
    yh[i,1]=1
    yh[i,i]=1
    m <- vector()
    m[1]=1
    m[i]=1
    if(i==1){
      s<-paste(c(rep(" " ,x-i+1)),sep="",collapse="")
      str<-paste(s,1,s," | sum:1",sep="",collapse="")
      print(str)
    }else if(i==2){
      s<-paste(c(rep(" " ,x-i+1)),sep="",collapse="")
      sum_m <- sum(m[1:i])
      str<-paste(s,paste(m,collapse=" "),s," | sum:",sum_m,sep="",collapse="")
      print(str)
    }else{
      for(a in 2:(i-1)){
        yh[i,a]=yh[i-1,a-1]+yh[i-1,a]
        m[a]= yh[i,a]
      }
      sum_m <- sum(m[1:i])
      s<-paste(c(rep(" " ,x-i+1)),sep="",collapse="")
      str<-paste(s,paste(m,collapse=" "),s," | sum:",sum_m,sep="",collapse="")
      print(str)
    }
  }
}

system.time(y(100))

#### h ####
gen_yang_triangle <- function(x){
  if(x==1){
    print(1)
  }
  else if(x==2){
    print(1)
    print(1,1)
  }
  else {
    print(1)
    print(1,1)
    t <-c(1)
    for(i in range(3,x+1)){
      pre <- c(0,t,0)
      #print(pre)
      for (j in range(1,i-1)){
        t<-c(1,pre[j]+pre[j+1],1)
        
      }
    }
  }
}

system.time(gen_yang_triangle(6))

#### s ####
s <-function(x) {
  bd <- matrix(0,nrow = x,ncol = x+1)
  bd[1,2]=1
  i=2
  kg<-""
  t=1
  while (t<=x-1) {
    kg <- paste(kg," ")
    t=t+1
  }
  cat (kg,bd[1,2]," ",kg,"\t","| sum : ","1","\n")
  while(i<=x){
    j=2
    s=1
    kk<- " "
    while(s <= x-i){
      kk <- paste(kk," ")
      s=s+1
    }
    cat (kk)
    while(j<=x+1){
      bd[i,j]=bd[i-1,j-1]+bd[i-1,j]
      if (bd[i,j] != 0){
        cat(bd[i,j]," ")
      }
      j=j+1
    }
    cat (kk,"\t","| sum : ",sum (bd[i,]),"\n")
    i=i+1
  }
  #print (bd)
}
system.time(s(5))

