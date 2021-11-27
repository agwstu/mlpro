###### Regresja ########
########################

###Loading data

data_r <- read.csv("~/Desktop/studia/magisterka/3sem/ML2/mlpro/dataset_31_credit-g.csv")

# Nie wiem, czy to bedzie dzialać, ale to dla Ciebie Mateusz <3
data_r <- read.csv("~/dataset_31_credit-g.csv")

# Wyświetlenie typów danych
str(data_r)

### Opisanie skali danych 
# checking_status- skala przedziałowa
# duration - skala ilorazowa
# credit history - skala nominalna
#  credit 