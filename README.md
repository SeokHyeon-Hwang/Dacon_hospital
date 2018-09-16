# Predicting the opening/closing of hosipitals

### 핀테크 회사인 MOUDA 에서는 병원들에 대출을 해주고자 한다. 신용점수가 낮거나 담보가 적더라도 상환기간 동안 병원이 운영된다면 대출해주고 한다. 상환기간 동안 병원의 생존 여부를 예측하라.

## files

train.csv - 의료기관이 폐업했는지 여부를 포함, 최근 2년간의 재무정보와 병원 기본정보

test.csv - 폐업 여부를 제외하고 train.csv와 동일

sample_submission.csv - 두 개의 열로 구성 하나는 inst_id, 다른 하나는 open과 close를 예측하는 OC. OC의 경우 open : 1, close : 0

## Data fields

### 기본정보

train : 301 obs. of  58 variables

test, sub : 127 obs. of  58 variables

inst_id - 각 파일에서의 병원 고유 번호

OC - 영업/폐업 분류, 2018년 폐업은 2017년 폐업으로 간주

sido - 병원 광역 지역 정보

sgg - 병원의 시군구 자료

openData - 병원의 설립일

bedCount - 병원이 갖추고 있는 병상의 수

instkind - 병원, 의원, 요양병원, 한의원, 종합병원 등 병원의 종류
(병원:hospital, 의원:clinic, 요양병원:nursing_hospital, 한의학 병원:traditional_ hospital, 한의학 의원:traditional_clinic, 종합병원:general_ospital, 치과:dental_clinic other:공란,closed)


employee1 – 고용한 총 직원의 수(2017)

employee2 – 고용한 총 직원의 수(2016)


ownerChange – 대표자의 변동 여부


### 재무제표


### 2017(회계년도)년 데이터를 의미

@@ : 재무상태표

$$ : 손익계산서

%% : 재무비율

^^ : 현금흐름분석

$$ revenue1 - 매출액

$$ salescost1 - 매출원가

$$ sga1 - 판매비와 관리비

salary1 - 급여

$$ noi1 - 영업외 수익

$$ noe1 - 영업외 비용

$$ Interest1 - 이자비용

$$ ctax - 법인세 비용

Profit1 - 당기순이익

@@ liquidAsset1 - 유동자산

quickAsset1 - 당좌자산

receivableS1 - 미수금(단기)

inventorAsset1 - 재고자산

@@ nonCAsset1 - 비유동자산

tanAsset1 - 유형자산

@@ OnonCAsset1 - 기타 비유동자산

receivableL1 – 장기미수금

debt1 – 부채총계

liquidLiabilities1 – 유동부채

shortLoan1 – 단기차입금

NCLiabilities1 – 비유동부채

longLoan1 – 장기차입금

@@ netAsset1 – 순자산총계

surplus1 – 이익잉여금



###  2016(회계년도)년 데이터를 의미

revenue2 – 매출액

salescost2 – 매출원가

sga2 - 판매비와 관리비

salary2 – 급여

noi2 – 영업외수익

noe2 – 영업외비용

interest2 – 이자비용

ctax2 – 법인세비용

profit2 – 당기순이익

liquidAsset2 – 유동자산

quickAsset2 – 당좌자산

receivableS2 - 미수금(단기)

inventoryAsset2 – 재고자산

nonCAsset2 – 비유동자산

tanAsset2 – 유형자산

OnonCAsset2 - 기타 비유동자산

receivableL2 – 장기미수금

Debt2 – 부채총계

liquidLiabilities2 – 유동부채

shortLoan2 – 단기차입금

NCLiabilities2 – 비유동부채

longLoan2 – 장기차입금

netAsset2 – 순자산총계

surplus2 – 이익잉여금





### 생각해 본 바

1. sgg는 시군구 구분인데 int로 되어있다. 분석 방향에 따라 factor로 바꿔줄 필요가 있다.

2. employee는 당해 고용직원수 이다. 헌데 factor로 되어있다. int나 num으로 바꿔 줄 필요가 있다.

3. instkind : 병원 형태가 나눠져 있다. filter 함수 등을 이용해서 병원형태+op/clo 를 나누어 분석할 수도 있겠다.

4. ownerchange : 오너 변경이 op/clo에 영향을 미치는 지도 확인해 볼 수 있겠다.

5. 자료를 제공한 Mouda라는 핀테크 회사에서 대출해 주려고 하는 회사는 다음과 같다. 재무제표와 담보가 적더라도.

그렇다면 재무제표의 요소들이 회사의 op/clo와 얼마나 상관관계가 있는지 볼 필요가 있겠다.


 
