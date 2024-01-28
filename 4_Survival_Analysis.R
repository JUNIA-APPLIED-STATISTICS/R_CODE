#Bienvenue dans le pratique de l'analyse de survie ("Survival Analysis") !
#L'analyse de survie est une forme d'analyse prédictive dans laquelle nous 
#construisons un modèle pour cartographier le taux et la probabilité qu'un 
#événement se produise.

#Cette méthode est à l'origine utilisée pour mesurer la survenue d'un décès
#dans une maladie ou un contexte particulier, mais elle est plus souvent 
#utilisée pour mesurer tout événement intéressant, comme le moment où une 
#personne tombe malade ou se rétablit.

#Pour cela, nous utiliserons la courbe de 'Kaplan-Meijer'.

#Cet essai clinique a été réalisé sur des femmes enceintes dans le but de 
#réduire leur risque de contracter le paludisme pendant leur grossesse.
#Dans cet exercice, nous déterminerons le taux et la probabilité de contracter 
#le paludisme pour les enfants nés de ces femmes enceintes
#Nous allons d'abord écrire ensemble un script pour déterminer ce taux et cette 
#probabilité

#Ensuite, vous choisirez une autre variable catégorielle qui, selon vous, a pu 
#avoir un impact sur le fait que cet enfant contracte le paludisme.

#Vous pouvez utiliser ici l'exemple de code réalisé avec la base R. Vous pouvez 
#également créer votre propre pré-traitement
#code si vous le souhaitez. Dans ce cas, assurez-vous que vous êtes familier 
#avec l'entrée et ce que vous voulez en sortiede vos données à ressembler.

#Vous pouvez également nommer vos trames de données comme vous le souhaitez, 
#mais il est plus facile pour moi de vous aider si je sais quelle partie
#de l'analyse que vous effectuez.



1.0
#Télécharger les packages
x <- c("lubridate", "ggsurvfit", "gtsummary", "tidycmprsk","data.table",'tidyr','dplyr','data.table','survival','condsurv','devtools')
install.packages(x)
devtools::install_github("zabore/condsurv")
lapply(x, require, character.only = TRUE)




1.1
#Apportez les ensembles de données
#PROMOTE_BC3_cohort_Participant_repeated_measures.txt et
#PROMOTE_BC3_cohort_Participants.txt
#à cet environnement
Repeated_measures <- 
Participants <-


1.2
#Sous-ensemble de l'ensemble de données Repeated_measures à inclure
#"Participant_Id"                          
#"Observation.date..EUPATH_0004991."       
#"Child.malaria.diagnosis..EUPATH_0042303."
Variables_of_intrest_RM <- Repeated_measures[,c(2,132,41)]

#Sous-ensemble de l'ensemble de données Participants à inclure
#"Participant_Id"
#"Delivery.date..EUPATH_0042043."  
Variables_of_intrest_P <- Participants[,c(1,86]
  
  
  
  
1.3 
#Fusionnez ces Variables_of_intrest_P et Variables_of_intrest_RM et supprimez les valeurs vides
Variables_of_intrest <- merge(Variables_of_intrest_RM,Variables_of_intrest_P,by="Participant_Id")
Variables_of_intrest[Variables_of_intrest == ""] <- NA
Variables_of_intrest <- na.omit(Variables_of_intrest)


  
  
1.4
#Utilisez la fonction as.Date() pour créer une autre colonne avec la différence en jours entre
#Date de livraison et Date d'observation
#Indice: Moins la date de livraison à partir de la date d'observation
Variables_of_intrest$Malaria_status <-ifelse(Variables_of_intrest$Child.malaria.diagnosis..EUPATH_0042303.== "No malaria", 0, 1)


  
1.5
#Dans l'analyse de survie, nous utilisons des variables muettes (dummy variables)
#pour marquer un événement = 1 et non-événement=0

#Utilisez la fonction ifelse() pour convertir le diagnostic de paludisme chez 
#l'enfant en variables fictives nominales "No malaria" = 0 et sinon = 1
#Enregistrez ceci dans une colonne séparée "Malaria_status"
Variables_of_intrest$date_diff <- as.Date(as.character(Variables_of_intrest$Observation.date..EUPATH_0004991.), format="%Y-%m-%d")-
  as.Date(as.character(Variables_of_intrest$Delivery.date..EUPATH_0042043.), format="%Y-%m-%d")
  
  

2.1
#Nous allons maintenant séparer le bloc de données en deux:
#un avec uniquement des cas de paludisme positifs et un avec uniquement des cas négatifs
#Créer une base de données distincte pour les observations avec uniquement un paludisme positif
#diagnostic en utilisant la fonction grep()
#convertir en table de données avec as.data.table()  
malaria_pos <- Variables_of_intrest[grep(1, Variables_of_intrest$Malaria_status),]
malaria_pos_DF =as.data.table(malaria_pos)



#Nous allons trouver la première date à laquelle l'enfant a reçu un diagnostic de paludisme
#Sous-définissez le malaria_pos_DF par la colonne dat_diff avec les règles suivantes:
#Tout d'abord, assurez-vous que le sous-ensemble sait que vous utilisez des symboles spéciaux (chr "jours") avec .SD
#Trouver la première date après l'accouchement où le paludisme a été diagnostiqué avec which.min() of date_diff
#Trier le sous-ensemble par=Participant_Id
malaria_pos_DF <- malaria_pos_DF[,.SD[which.min(date_diff)],by=Participant_Id]

  

#Créez un vecteur des identifiants des participants avec un diagnostic positif de paludisme
participants_with_malaria <- malaria_pos_DF$Participant_Id

  
  
  
2.2
#On fait pareil pour les cas négatifs mais on constate que le dernier jour c'était du paludisme
#négatif
#Créer une base de données distincte pour les observations avec uniquement un paludisme négatif
#diagnostic en utilisant la fonction grep()
#convertir en table de données avec as.data.table()
malaria_neg <- Variables_of_intrest[grep(0, Variables_of_intrest$Malaria_status),]
malaria_neg_DF=as.data.table(malaria_neg)



#Nous allons trouver la dernière date à laquelle l'enfant a été déterminé négatif au paludisme
#Sous-définissez le malaria_neg_DF par la colonne date_diff avec les règles suivantes:
#Tout d'abord, assurez-vous que le sous-ensemble sait que vous utilisez des symboles spéciaux (chr "jours") avec .SD
#Trouvez la première date après l'accouchement où le paludisme a été diagnostiqué avec which.max() de date_diff
#Trier le sous-ensemble par=Participant_Id
malaria_neg_DF <- malaria_neg_DF[,.SD[which.max(date_diff)],by=Participant_Id]


  
#Enfin, nous supprimons les cas positifs pour le paludisme par identifiant de participant
#en utilisant le vecteur participants_with_malaria
#Vous pouvez le faire plus facilement en transmettant le résultat avec la fonction dplyr %in%
#sur le vecteur participants_with_malaria
malaria_neg_DF <- malaria_neg_DF[ ! malaria_neg_DF$Participant_Id %in% participants_with_malaria, ]


  
3.1
#Liez malaria_neg et malaria_pos par lignes en utilisant rbind()
Whole_DF_Malaria_Status <- rbind(malaria_neg_DF,malaria_pos_DF)


3.2
#Extraire les colonnes avec le statut de paludisme (numérique), le moment depuis la naissance
#event s'est produit (date_diff) dans le dataframe "Malaria"

#Lorsque vous avez choisi votre propre variable catégorielle après le point 5.1, incluez cette variable
#aussi
Malaria <- Whole_DF_Malaria_Status[,c(6,7)]



4.1
#Le prétraitement est maintenant terminé
#Utilisez la fonction Surv() pour créer un "objet de survie"
#Cette fonction détermine les contenus censurés et non censurés
#observations dans les données:

#Données censurées: une observation comme 355+ signifie qu'à 355 jours post-partum, à la fin de l'essai, ce cas est toujours en cours.
#n'avait pas contracté le paludisme. L'événement (diagnostic positif du paludisme) ne s'est pas produit, il s'agit donc d'un
#Point de données "censuré"

#Une observation sans signe plus comme 160 signifie que cet enfant a contracté le paludisme
#à 160 jours post-partum. L'événement (diagnostic positif de paludisme) s'est produit, il s'agit donc d'un
#Point de données "non censuré"

#Utilisez la documentation dans le fichier Github README pour un exemple de syntaxe
Survival_object <- Surv(Malaria$date_diff, Malaria$Malaria_status)



4.2
#Imbriquer la fonction Surv() complète ci-dessus dans la fonction survfit()
#Cette fonction vous récupérera des informations sur le nombre de participants
#ont reçu un diagnostic de paludisme (événements), les jours médians jusqu'à l'événement pour
#happen, et l'intervalle de confiance supérieur et inférieur pour cette observation
#Utilisez la documentation dans le fichier Github README pour un exemple de syntaxe
survfit(Surv(date_diff, Malaria_status) ~ 1, data = Malaria)




4.3
#Nous utiliserons survfit2() en conjonction avec ggsurvfit() pour créer
#nos parcelles de Kaplan-Meijer !
#Imbriquer la fonction Surv() complète de la version 4.1 dans la fonction survfit2()
#Ajoutez un intervalle de confiance et un tableau de risque en utilisant ggsurvfit()
#Utilisez la documentation dans le fichier Github README pour un exemple de syntaxe
survfit2(Surv(date_diff, Malaria_status) ~ 1, data = Malaria) %>% 
  ggsurvfit() +
  labs(
    x = "Days",
    y = "Overall survival probability"
  )+ 
  add_confidence_interval()+
  add_risktable()
                                          


#Dans ce graphique, vous pouvez voir la probabilité de survie (par exemple, ne pas développer le paludisme)
# sur l'axe Y et les jours pour chaque probabilité sur l'axe X.
#Par exemple: au jour 200 post-partum, les enfants n'avaient malheureusement qu'une probabilité de 58%
# de ne pas avoir contracté le paludisme avec 253 cas de diagnostics de paludisme.
#Au 300e jour, cette probabilité est tombée à 40 % avec 353 cas de diagnostic de paludisme.
#À la fin de l'étude, au jour 400 du post-partum, 407 enfants étaient à un certain âge.
#point paludisme positif.

#Maintenant, encore une fois, revenons au début et vous choisirez votre propre variable
#Cette fois, la variable principale ("Child.malaria.diagnosis..EUPATH_0042303.") reste la même,
#mais nous souhaitons inclure une autre variable categoriale (e.g. Oui/Non, Type of bednet) à ajouter aux données.
#Nous verrons comment cette variable a impacté le diagnostic du paludisme.
#Retournez à 1.2 et incluez votre variable d'intérêt dans votre ensemble de données.
#N'oubliez pas de l'inclure également dans 3.2 lors du sous-ensemble de la trame de données finale
#Il n'est pas nécessaire de transformer la variable de votre choix en variables factices à 1.5

###################################################################################


5.1
#Maintenant, vous avez incorporé la variable de votre choix
#incorporez-le dans l'analyse suivante en remplaçant le ~1 de la syntaxe en 4.1 comme variable
#Trouvez les décomptes et l'heure médiane de l'événement pour votre variable
#en imbriquant la fonction Surv() dans la fonction survfit() et en spécifiant votre
#variable avec ~(votre_variable)
#vérifiez le fichier Github README pour un exemple de syntaxe
survfit(Surv())



5.2
#Trouvez la probabilité sur un an que les participants développent le paludisme
#sur la variable de votre choix
#Vous pouvez copier la syntaxe ci-dessus et ajouter tbl_survfit() avec times = 365.25
#vérifiez le fichier Github README pour un exemple de syntaxe
survfit(Surv()) %>% 
  tbl_survfit()




5.3
#Créez une courbe de Kaplan-Meijer avec survfit2() pour représenter l'ensemble
#probabilité de survie en stratifiant la courbe en fonction de la variable de votre choix
#Ajoutez un intervalle de confiance et un tableau de risque avec ggsurvfit()
#vérifiez le fichier Github README pour un exemple de syntaxe
survfit2(Surv()) %>%
  ggsurvfit()




5.4
#enregistrez votre bloc de données "Malaria" localement sur votre PC pour le prochain cours, lorsque nous
#effectuer des statistiques inférentielles
write.table(Malaria,"your path here")



########################################################################################### 

#In your presentation, include the figures and the tables of following:

5.1 # The total proportion and median of a child contractng malaria based on your variable of choice & interpretation
5.2 # The 1-year survival probability based on your variable of choice & interpretation
4.3 # The Kaplan-Meijer curve based on your variable of choice & interpretation

########################################################################################### 
