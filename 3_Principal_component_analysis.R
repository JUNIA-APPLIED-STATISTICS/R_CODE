
#Bienvenue dans la pratique de l'analyse en composantes principales (PCA)!
#PCA est un outil d'analyse exploratoire, que nous utiliserons pour trouver une corrélation entre des variables numériques quantitatives
#Vous ne pouvez pas tirer de conclusions directes de l'analyse exploratoire, mais elles sont là pour être utilisées comme
#une méthode pour trouver des corrélations qui peuvent ensuite être testées avec des statistiques inférentielles (nous allons faire
#c'est la classe 5)

#Dans cette analyse, nous explorerons pour voir quelles variables numériques sont corrélées
#dans le jeu de données "Repeated measures"
#Nous allons d'abord écrire un exemple de script, puis vous choisirez vos propres variables que vous souhaitez explorer
#avec l'exemple de script.

#Vous pouvez utiliser ici l'exemple de code réalisé avec la base R. Vous pouvez également créer votre propre pré-traitement
#code si vous le souhaitez. Dans ce cas, assurez-vous que vous êtes familier avec l'entrée et ce que vous voulez en sortie.
# de vos données à ressembler.

#Vous pouvez également nommer vos trames de données comme vous le souhaitez, mais il est plus facile pour moi de vous aider si je sais quelle partie
# de l'analyse que vous effectuez.


1.1
#Nous avons déjà installé FactorMineR et factoextra à partir de l'analyse de correspondance précédente
#Amenez ces packages dans cet environnement de travail






1.2
#Vous aurez besoin du fichier :
#PROMOTE_BC3_cohort_Participant_repeated_measures.txt
Rep_measures <- 
  
  
  


2.1
#Cette étude était une étude clinique réalisée sur des femmes enceintes
#Dans la base de données «Participants», nous avons trouvé les informations sur ces femmes, leur grossesse
#et leurs enfants précédents.
#L'ensemble de données de mesures répétées sert à surveiller la santé des nouveau-nés et des mères après
#donner naissance
#Examinons donc comment les paramètres médicaux des nouveau-nés sont corrélés les uns aux autres en utilisant le
#Frame de données "Rep_measures"!

#Nous sommes prêts à commencer le prétraitement de notre base de données pour analyse
#Pour ce faire, nous allons sous-ensembler notre bloc de données "Rep_measures" pour inclure 6 valeurs numériques
#et 1 variable catégorielle:
#"Diagnostic.du.paludisme.enfant..EUPATH_0042303."
#"Âge.de.l'enfant..semaines...EUPATH_0042293."
#"Fréquence.cardiaque.de.l'enfant..bpm...EUPATH_0042290."
#"Circonférence.de.tête.de.l'enfant..cm...EUPATH_0042288."
#"Fréquence.respiratoire.de.l'enfant..respirations.min...EUPATH_0042329."
#"Température.enfant..C...EUPATH_0042340."
#"Poids.de.l'enfant..kg...EUPATH_0047385."
pca_variables <- 
  
  
  
2.4
#Pour que toute analyse soit impartiale, nous incluons uniquement des cas complets.
#Éliminer les valeurs NA et vides
pca_variables <- 
  
  
  
  
2.5
#Nous avons inclus une variable qualitative dans notre analyse. Nous l'utiliserons pour
#interprétation de notre PCA, mais comme elle n'est pas quantitative nous ne pouvons pas l'utiliser
#it pour l'analyse PCA elle-même
#Repérez la variable qualitative et extrayez-la des données dans un vecteur
#Nommez ce vecteur "qualitative_variable"
#Modifiez les valeurs vectorielles du niveau de caractère au niveau de facteur avec as.factor()
#Enfin, supprimez cette variable du bloc de données "pca_variables"
qualitative_variable <-
pca_variables <- 
  
  
  
2.2
#L'analyse #PCA ne prend que des données matricielles pour l'analyse
#Utilisez la fonction data.matrix() pour changer la structure de pca_variables
#dans une matrice.
pca_variables_matrix <- 




2.3
#Pour l'analyse PCA, nous devons mettre à l'échelle nos données.
#Il s'agit de normaliser les données, par ex. pour s'assurer que chaque variable a la même chose
#poids dans l'analyse tout en conservant leur contribution relative à
#la variabilité de l'ensemble de données.
#Utilisez la fonction scale() pour centrer notre matrice'
#Set scale=FALSE afin d'extraire uniquement la moyenne centrale et de ne pas utiliser l'écart type
#Comme méthode de normalisation (je sais, déroutant)
#nommez votre résultat pca_variables_scaled
pca_variables_scaled <- 
  
  
2.4
#Renommer les colonnes de pca_variables_scaled comme vous le souhaitez pour votre présentation




3.3
#Super!
#Nos données sont désormais sous forme matricielle et normalisées pour PCA.
#Nous sommes prêts à réaliser une PCA.
#Utilisez la fonction PCA() (en majuscules) sur les données pca_variables_scaled
#nommer ceci comme pca_result
#Le graphique qui en résulte s'appelle un cercle de corrélation (correlation circle).
#Vous verrez comment les variables sont corrélées. Les variables avec une corrélation positive sont
#plus proches les unes des autres et les variables qui sont corrélées négativement sont géométriquement sur un
#quadrant opposé à son homologue. La distance des variables à l'origine géométrique
#signifie dans quelle mesure cette variable a un impact sur la variance globale trouvée dans l'ensemble de données.
pca_result <- 
  
  
  
  
  
3.4
#Vérifions la fiabilité de l'analyse avec l'utilisation de valeurs propres (Eigenvalue)
#Utilisez fonction get_eigenvalue()
#Nous devrions choisir autant de dimensions que nous en avons avec des valeurs propres >1, sinon nous perdons
#une quantité importante d'informations

#Avec PCA, on appelle les dimensions « composants principaux » (Principal component, PC)
#La première dimension est PC1, la deuxième PC2 et ainsi de suite

#Sur combien de PC devrions-nous nous appuyer dans cette analyse basée sur les valeurs propres?
#Utilisez fviz_eig() pour visualiser ces valeurs dans un éboulis
get_eigenvalue(pca_result)
fviz_eig(pca_result)





#Comme dans l'analyse des correspondances, vous allez maintenant effectuer une analyse sur les variables
#de votre choix. Choisissez des variables en fonction des critères suivants:
# 1) Trouvez les variables liées aux mesures répétées de la mère (donc tout
#sauf pour les colonnes commençant par "Child"). Choisissez ceux qui vous intéressent et dont vous voulez savoir s'ils sont ou non
#influencer les uns les autres
#2) Les variables doivent être quantitatives et de préférence continues
# 3) Choisissez au moins 5 variables quantitatives. En plus de cela, choisissez 1 variable qualitative
#(par exemple, variables avec des niveaux catégoriels, comme le diagnostic du paludisme : oui/non)
#Au total, vous aurez 6 variables
#Vous pouvez combiner l'ensemble de données des ménages ou des participants dans votre analyse si vous le souhaitez
#Sous-ensemblez à nouveau votre dataframe à 2.1, y compris toutes vos variables
#Une fois que vous avez choisi et sous-défini votre dataframe dans 2.1, exécutez le code précédent
#et continuez avec 4.1


###########################################################################################


4.1
#Maintenant, examinons comment chacun des individus est assis en premier et en second
#dimension de notre tracé pca en utilisant la fonction fviz_pca_ind()


#La qualité de représentation des variables sur le tracé pca (« factor map ») est appelée cos2 (cosinus carré ; coordonnées au carré).
#Un cos2 élevé indique une contribution plus importante de la variable on dans le PC donné.

#Définissez le graphique pour inclure la valeur du cosinus 2 (cos2) de chaque individu
fviz_pca_ind()





4.2
#Maintenant, nous allons examiner nos variables séparément des cas individuels avec
#la fonction fviz_pca_var()
#Définissez le graphique pour inclure la valeur du cosinus 2 (cos2) de chaque variable
#Au PCA dans les deux premières dimensions
fviz_pca_var()






4.3
#Nous allons maintenant voir comment les variables et les observations évoluent les unes par rapport aux autres
#Les uns aux autres ET regrouper les variables en fonction d'une variable qualitative
#tu as choisi
#Utilisez la fonction fviz_pca_biplot()
#Définissez l'habillage comme variable qualitative (enregistrée sous qualitative_variable précédemment) de votre choix
#Ajouter une ellipse et définir le niveau d'ellipse à 0,95
#label uniquement les variables pour un graphique plus clair
fviz_pca_biplot()





#Parfait! Votre analyse est maintenant terminée


########################################################################################### 

#In your presentation, include the figures and the tables of following:

3.1 # Scree Plot, eigenvalues and its interpretation 
4.2 # Correlation circle of variables and their respective cos2 values and its interpretation
4.3 #A Biplot with clustering of individuals, and how the variables impact the individuals and clusters

########################################################################################### 
