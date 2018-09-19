rm(list=ls())
search()
trdf<-read.csv('E:/Bigdata/dataset/dacon/train.csv')
tedf<-read.csv('E:/Bigdata/dataset/dacon/test.csv')
str(trdf)
summary(trdf)
table(trdf$instkind)

em_ch<-(trdf$employee1-trdf$employee2)
em_ch
trdf[3,]
head(trdf)
trdf<-trdf

search()
##sgg:levels
library('Amelia')
missmap(trdf)
sapply(trdf, function(x) sum(is.na(x)))
search()
## tr_sub<- em2:57, em1:56, bc:6, ocha:58 
colnames(trdf)
#tr_sub<-trdf[, -57]
#tr_sub<-tr_sub[, -56]
#tr_sub<-tr_sub[, -6]
#tr_sub<-tr_sub[, -58]
library('dplyr')
tr_sub<-select(trdf, -c(employee2, employee1, bedCount, ownerChange))


int<-trdf$interest1-trdf$interest2
inv<-trdf$inventoryAsset1-trdf$inventoryAsset2
liq<-trdf$liquidLiabilities1-trdf$liquidLiabilities2
nca<-trdf$nonCAsset1-trdf$nonCAsset2


tr_sub<-cbind(tr_sub, int)
tr_sub<-cbind(tr_sub, inv)
tr_sub<-cbind(tr_sub, liq)




missmap(tr_sub)
tr_sub_noNA<-tr_sub[!is.na(tr_sub$salary1),]


missmap(tr_sub_noNA)
## omit.na



# 모델 만들기
library(randomForest)
#rf_model<-randomForest(factor(OC)~., data=tr_sub_noNA)
rf_model<-randomForest(factor(OC)~ interest1 + 
                       interest2+ shortLoan1 +surplus1, data=tr_sub_noNA)
rf_model
# 변수의 중요도
importance<-importance(rf_model)
importance

colnames(trdf)

## shortLoan1, 

plot(trdf$surplus1, type='l')
lines(trdf$surplus2, col='red', lty='dashed')

plot(trdf$inventoryAsset1, type='p')
points(trdf$inventoryAsset2, col='red', lty='dashed')
plot(inv)
plot(int)
plot(liq)



sel<-c('interest1', 'interest2', 'shortLoan1', 'surplus1')
te_sub<-select(tedf, -c(employee2, employee1, bedCount, ownerChange))
str(te_sub[,sel])

te_sub1<-te_sub[,sel] # 데이터 중 sel만 선택
missmap(te_sub)

''' 
for ( idx in 범위) {
    실행문1
    실행문2
}
'''
'''
if (조건문) {
   실행문
}
'''
te_sub1[[1]]
class(te_sub1[1])

lenVal=length(te_sub1)
lenVal
#class(te_sub1)[[1]]
#te_sub1[1]  : data.frame
#te_sub1[[1]]  : list
for ( i in 1:lenVal) {
  type=class(te_sub1[[i]])
  if (type=='numeric'){
  # (1) 해당열의 평균값 구하기  (2) NA 위치 확인 (3) 값을 평균값으로 치환
  ##(1) 평균값
    meanVal = mean(te_sub1[[i]], na.rm = T)
  ##(2) NA 위치 확인
    loc=which(is.na(te_sub1[[i]]))
  ##(3) 값을 치환
    te_sub1[loc, i] = meanVal
    
  }

  
  if (type=='integer'){
    # (1) 해당열의 평균값 구하기  (2) NA 위치 확인 (3) 값을 평균값으로 치환
    ##(1) 평균값
    meanVal = mean(te_sub1[[i]], na.rm = T)
    ##(2) NA 위치 확인
    loc=which(is.na(te_sub1[[i]]))
    ##(3) 값을 치환
    te_sub1[loc, i] = as.integer(meanVal)
    
  }
  
}





missmap(te_sub1)
prediction<-predict(rf_model, newdata=te_sub1)
prediction<-ifelse(prediction=='open', 1, 0)
sub<-read.csv('E:/Bigdata/dataset/dacon/submission_sample.csv')
sub$OC<-prediction
write.csv(sub, file='sub_0919_3_3.csv', row.names=F)


getwd()
