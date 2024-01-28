#Bienvenue dans la partie statistiques inférentielles de ce cours!
#Nous examinerons l'analyse que nous avons effectuée et testerons si ce que vous avez trouvé dans votre
#L'analyse précédente (MCA, PCA et analyse de survie) est statistiquement significative.

#Pour MCA et PCA, revenez à votre analyse et choisissez deux variables de chaque analyse:
#Choisissez les variables qui vous intéressent et qui peuvent être corrélées négativement ou positivement.
#Nous testerons la force et la signification statistique de ces corrélations

#Vous avez tous différents types de variables, vous choisirez donc votre propre inférence
#approche d'analyse par vous-même (bien sûr, vous pouvez vérifier avec moi.)


#Vous effectuerez également votre propre prétraitement, qui comprend
#1) sous-ensemble de votre ensemble de données,
# 2) supprimer les variables manquantes
#3) choisissez votre approche
# 4) Assurez-vous que les hypothèses de données de votre approche statistique sont valables dans vos données
#(pour les variables PCA)
#Par exemple, la régression linéaire suppose que vos données sont linéaires et
#t-test suppose des données normalement distribuées

#Vous trouverez la documentation de ces approches dans le fichier Github README.

############################################### ## ######################################


1.0
x <- c('tidyverse','ggplot2','ggpubr','gtsummary','gt','readxl',"car","Hmisc",'corrplot', 'survie')
install.packages(x)
lapply(x, require, character.only = TRUE)



1.1
#Apportez vos trames de données pour analyse
Repeated_measures <- read.delim()
Participants <- read.delim()
Households <- read.delim()
Survival_Dataframe_from_last_class <- read.table()

############################################### ## ######################################

2.0 #Statistiques inférentielles MCA


#Choisissez deux variables parmi vos résultats MCA, qui
#vous êtes curieux de savoir s'ils sont corrélés
#Ensuite, choisissez vous-même quel test statistique significatif vous souhaitez utiliser pour vérifier la
#importance de votre découverte en fonction des variables dont vous disposez


2.1
#Sous-ensemblez vos variables du bloc de données et supprimez les valeurs manquantes






2.2
#Déterminez le type de variables avec lesquelles vous travaillez.
#Ensuite, choisissez un outil d'analyse statistique qui détermine
#s'il existe une corrélation significative entre les variables
#Où vos variables sont indépendantes ou dépendantes ?








################################################# #########################################

3.0 #Statistiques inférentielles PCA

#Choisissez deux variables parmi vos résultats PCA, qui
#vous êtes curieux de savoir s'ils sont corrélés
#Tout d'abord, nous allons vérifier les hypothèses des données:
#Les données sont-elles normalement distribuées?
#Ensuite, choisissez vous-même quel test vous souhaitez utiliser pour vérifier le
#importance de votre découverte.


3.1
#Sous-ensemblez vos variables du dataframe et supprimez les valeurs manquantes







3.2
#Vérifiez la normalité des données avec un histogramme et avec le test Shapiro-Wilk
#Vous devez tester cela avec une variable à la fois

#Variable d'histogramme 1
gghistogramme()


#Shapiro-Wilk Test pour vérifier la distribution normale de la variable 1
test <- shapiro.test()
alpha = 0,05 #valeur significative

si(test$p.value > alpha){
  print("L'échantillon a une distribution gaussienne/normale")
} autre {
  print("L'échantillon n'a pas de distribution gaussienne/normale")
}



#Variable d'histogramme 2
gghistogramme()


#Shapiro-Wilk Test pour vérifier la distribution normale de la variable 2
test <- shapiro.test()
alpha = 0,05 #valeur significative

si(test$p.value > alpha){
  print("L'échantillon a une distribution gaussienne/normale")
} autre {
  print("L'échantillon n'a pas de distribution gaussienne/normale")
}


3.4
#Déterminez le type de variables avec lesquelles vous travaillez.
#1) De quels types de variables s'agit-il (continu/intervalle/rapport, etc.) ?
#2) Sont-ils normalement distribués ?
# 3) Vérifiez-vous la différence ou la corrélation?
#Sur la base de ces facteurs, appliquer un outil d'analyse statistique qui détermine
#si cet effet est significatif ou non:






3.5
#Maintenant, apportez toutes les variables que vous avez utilisées pour PCA et supprimez les valeurs manquantes
#et votre valeur catégorielle et vos variables d'identification (par exemple Household_Id)




3.6
#Utilisez cette même approche statistique que celle que vous avez choisie ci-dessus
#pour créer une matrice de corrélation avec des valeurs p

#Un graphique de corrélation résume toutes les corrélations entre les variables numériques de vos données

#Utilisez rcorr() pour déterminer le coefficient de corrélation et les valeurs p, et corrplot() pour les visualiser
#des relations.
#N'oubliez pas d'appliquer votre méthode statistique dans la fonction rcorr() avec type = "votre test souhaité"
#Vérifiez le README de github pour un exemple de syntaxe






########################################################################################### 


4.0 #Survie Analyse Statistiques inférentielles
#Le test du log-rank est une méthodologie statistique permettant de comparer la distribution du temps jusqu'à ce que
#la survenance d'un événement d'intérêt dans des groupes indépendants.
#Utilisez la trame de données enregistrée à partir de l'analyse de survie (celle avec
#votre variable de choix incluse) du dernier cours et appliquez-la au
#Fonction survdiff(). La fonction survdiff() effectuera automatiquement un prétraitement et exécutera le
#analyse statistique pour votre analyse de survie
#Vérifiez le README de github pour un exemple de syntaxe
survdiff()




########################################################################################### 

#In your presentation, include the figures and the tables of following:

2.2 # With your multiple correspondence analysis, include the statistical significance 
#between two of your variables of interest & interpretation
3.6 # In your principal component  analysis, include the correlation matrix of the 
#variables you used for PCA & interpretation
4.0 # With your survival analysis, include the results of your log-rank test
#based on your variable of choice & interpretation

########################################################################################### 