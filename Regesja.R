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
# purpose - skala nominalna
# credit_amount - skala ilorazowa
# saving_status - skala przedzialowa
# employment  - skala przedzialowa
# installment_commitment - skala porządkowa 
# personal_status - skala nominalna 
# other_parties - nie wiem ?
# residence_since - ilorazowa ?
# property_magnitude - nominalna ?
# age - absolutna 
# other_paument_plans - nomianlna?
# housing - nominalna 
# existing_credits - ilorazowa ?
# job - nominalna 
# num_dependents ?
# own telephone - nomianlna
# foreign_woreker - nominalna
# class - nominalna 


