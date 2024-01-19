#Bienvenue dans la pratique de l'analyse des correspondances multiples (MCA)!
#MCA est un outil d'analyse exploratoire, que nous utiliserons pour trouver une corrélation entre les variables catégorielles
#Vous ne pouvez pas tirer de conclusions directes de l'analyse exploratoire, mais elles sont là pour être utilisées comme
#une méthode pour trouver des corrélations qui peuvent ensuite être testées avec des statistiques inférentielles (nous allons faire
#c'est la classe 5)

#Dans cette analyse, nous explorerons nos ensembles de données pour voir quelles variables catégorielles dans les «Participants»
#et les jeux de données "Households" sont corrélés entre eux
#Nous allons d'abord écrire un exemple de script, puis vous choisirez vos propres variables que vous souhaitez explorer
#avec l'exemple de script.

#Vous pouvez utiliser ici l'exemple de code réalisé avec la base R. Vous pouvez également créer votre propre pré-traitement
#code si vous le souhaitez. Dans ce cas, assurez-vous que vous êtes familier avec l'entrée et ce que vous voulez en sortie.
# de vos données à ressembler.

#Vous pouvez également nommer vos trames de données comme vous le souhaitez, mais il est plus facile pour moi de vous aider si je sais quelle partie
# de l'analyse que vous effectuez.

#Dans le fichier README de Github, il existe des documents utiles pour MCA dans R
#Pour chaque fonction, vous pouvez vérifier la documentation et les paramètres avec le
#?fonction



1.1
#Installons et introduisons dans cet environnement deux packages pour notre analyse:
#fonctions dont vous avez besoin: install.packages() et library()
#packages à installer : "FactorMineR" et "factoextra"
install.packages(c("FactoMineR", "factoextra"))
library("FactoMineR")
library("factoextra")



1.2
#Maintenant, nous apportons nos fichiers de données pour l'analyse. Vous aurez besoin des fichiers :
#PROMOTE_BC3_cohort_Participants.txt
#PROMOTE_BC3_cohort_Households.txt
#utilisez la fonction read.delim() pour importer ces fichiers dans R pour analyse
#Nommez ces fichiers respectivement «Participants» et «Households»
Participants <- read.delim(,header = T)
Households <- read.delim(,header = T)



2.1
#Nous sommes prêts à commencer le prétraitement de nos trames de données pour analyse
#Pour ce faire, nous allons sous-ensembler nos blocs de données pour inclure deux variables:
# 1) Placental.malaria..EUPATH_0042117 de la trame de données "Participants" dans variables_of_intrest_P
# 2) Household.bednets..EUPATH_0020232.from la base de données "Households" dans variables_of_intrest_H
#Parce que ces variables proviennent de 2 blocs de données différents, nous devons également
#extraire l'identifiant commun "Household_Id" des deux trames de données
#afin de combiner les deux trames de données à l'étape suivante

#Utilisez la fonction colnames() pour retrouver les colonnes de ces variables si nécessaire
variables_of_intrest_P <- Participants[,c(2,134)]
variables_of_intrest_H <- Households[,c(1,40)]




2.2
#Maintenant, nous avons deux sous-ensembles de données provenant des «Participants» et
#Ensembles de données "Households" en "variables_of_intrest_P" et "variables_of_intrest_H",
#respectivement. Nous utiliserons la fonction merge() pour combiner ces ensembles de données
#par "Household_Id". N'oubliez pas de définir all.x = TRUE pour inclure tous les cas.
variables_of_intrest_P <- merge(variables_of_intrest_P, variables_of_intrest_H, by = "Household_Id", 
                                all.x = TRUE) 




2.3
#Super! Nous avons nos ensembles de données fusionnés et nous n'avons pas besoin de la variable commune
#"Household_Id" plus pour analyse. Nous pouvons supprimer cette colonne de l'ensemble de données fusionné et la nommer
#as mca_variables
mca_variables <- variables_of_intrest_P[,-1]



2.4
#Maintenant, lorsque vous regardez le bloc de données, nous pouvons voir que tous les cas ne sont pas complets :
View(mca_variables)
#par exemple. il manque des valeurs "vides".
#Pour que toute analyse soit impartiale, nous incluons uniquement des cas complets.
#Les valeurs vides ne peuvent pas être éliminées telles quelles, nous devons plutôt les préciser
#qu'il s'agit de valeurs NA (non disponible).
#Prenez toutes les valeurs vides dans mca_variables et remplacez-les par NA
#Indice: Les variables vides sont exprimées sous la forme: ""
mca_variables[mca_variables == ""] <- NA



2.5
#Super! Nous allons maintenant utiliser la fonction na.omit() pour supprimer toutes les lignes qui sont
#pas complet avec les données.
mca_variables <- na.omit(mca_variables)



2.7
#Nous allons maintenant renommer les noms des colonnes pour la présentation
#utilisez la fonction colnames() pour renommer vos colonnes comme vous le souhaitez pour la présentation
colnames(mca_variables)=c("Placental Malaria","Household Bednets")



3.1
#Nos données sont prêtes à être analysées!
#Nous allons maintenant effectuer une MCA pour déterminer si le type de moustiquaire
#les sujets utilisés sont en corrélation avec la météo ou non, ils ont été diagnostiqués
#avec paludisme placentaire
#Utilisez la fonction MCA() sur votre dataframe mca_variables et enregistrez le résultat sous "mca"
#Définissez votre "graph = FALSE", nous exécuterons la représentation séparément
#mca sera une liste avec les résultats numériques de votre analyse
#Cette liste stocke toutes les informations de mca, et nous les utiliserons pour analyser les résultats
mca <- MCA(mca_variables,
           graph = FALSE)
  


#Lorsque nous utilisons le résumé (mca), nous pouvons examiner comment chaque individu et variable
#impacte le résultat
#Dim.X = valeur de coordonnée
#contrib = contribution quantifiée à la construction de la dimension
#cos2= qualité de représentation (mesurée en cosinus carré)
#v.test = signification statistique: une valeur inférieure à -1,96 ou supérieure à 1,96 est considérée comme significative (par exemple,
#cette variable a une contribution statistiquement significative à la dimension)
#Remarque: il ne s'agit pas d'un niveau de signification comme la valeur p, mais prend plutôt en compte le
#importance de cette variable dans sa seule contribution à cette analyse.
#eta2= rapport de corrélation de chaque variable entre dimensions. Nous permet de tracer
#les données.
summary(mca)




#Avec la fonction dimdesc() nous pouvons voir des statistiques inférentielles à partir de ce résultat
#pour chaque dimension et chaque variable

#Pour "Lien entre la variable et la variable catégorielle (anova 1 voie)"
#R^2 = valeur de corrélation R au carré qui montre dans quelle mesure le modèle prédit le résultat de
#la variable dépendante.
#p.value = cette corrélation est-elle significative


#Pour "Lien entre variable et les catégories des variables catégorielles"
#Estimation = valeur de coordonnée de la variable
#p.value = si cette coordonnée diffère significativement de 0 (par exemple, aucun impact
#sur la dimension)
dimdesc(mca)

var <- get_mca_var(mca)

# Here, you can see the coordinates of each factor
head(var$coord)
# Cos2: quality on the factor map
head(var$cos2)
# Contributions to the variability in each dimension
head(var$contrib)


#Une photo vaut plus de 1 000 de mots !
#Nous pouvons tracer beaucoup de ces informations, et nous y ferons référence
#statistiques à travers un graphique.




3.2
#Maintenant, nous allons créer un MCA Biplot pour présenter nos données
#Dans ce contexte, un biplot tracera à la fois les variables ET les cas
#Utilisez fviz_mca_biplot() pour créer ce graphique basé sur les données de "mca"
#set "repel = TRUE" et "ggtheme = theme_minimal()" pour un graphique plus clair
#Essayez ?fviz_mca_biplot() pour mieux comprendre cette fonction





#Le résultat est un graphique bidimensionnel représentant les variables (rouge) et les cas (bleu)
#et comment ils sont en corrélation les uns avec les autres.
#Les cas seront automatiquement regroupés, comme le montrent les lignes bleues.
#si vous définissez label="var" vous ne pouvez voir que les variables (rouges) et les cœurs du
#clusters (bleu)
#Les variables les plus proches les unes des autres sont plus corrélées
#Le « Oui » correspond à un diagnostic positif du paludisme et le « Non » à un diagnostic négatif.
#Le reste des variables concerne le type de moustiquaire utilisé par les participants.

#À partir de ce graphique, nous pouvons tenter de répondre à quelques questions :
#1) Le fait d'avoir une moustiquaire a-t-il un impact sur la contraction du paludisme?
#2) Pour les cas où le type de traitement des moustiquaires était inconnu, quel type de
#moustiquaire, diriez-vous qu'elles étaient basées sur le biplot?
# 3) Quelles variables seriez-vous intéressé à examiner avec des statistiques inférentielles
#si ils sont statistiquement corrélés ?

#################################################################################################


#Maintenant, nous revenons au point 2.2, et vous inclurez tous votre propre analyse
#Choisissez les variables que vous souhaitez parmi les « households » et les « participants »
#frames de données avec les règles suivantes:
# 1) Choisissez des variables nominales ou ordinales
# 2) Choisissez les variables qui vous intéressent et qui peuvent être corrélées
# 3) Assurez-vous que les colonnes que vous sélectionnez ne contiennent pas principalement des valeurs manquantes, sinon le
#l'analyse ne fonctionnera pas
# 4) Choisissez au moins 6 variables
#Ajoutez ces variables aux ensembles de données "variables_of_intrest_P" et "variables_of_intrest_H"
#N'oubliez pas d'inclure le "Household_Id" pour fusionner les ensembles de données
#Vous n'avez rien d'autre à changer dans le script ci-dessus, puisque vous l'avez maintenant
#l'a automatisé pour l'analyse
#Continuez votre analyse à partir de 4.1 lorsque vous avez sous-ensemble vos variables d'intérêt




4.1
#Maintenant, vous avez vos propres variables d'intérêt et votre premier tracé MCA-Biplot.
#Plongeons un peu plus en profondeur!
#Nous allons maintenant voir à quel point les tracés mca sont fiables pour l'interprétation
#Nous allons examiner le graphique d'éboulis à partir de notre analyse pour déterminer comment
#Une grande partie de la variance peut être expliquée par chaque dimension de l'analyse MCA
#Utilisez la fonction get_eigenvalue() pour obtenir les valeurs propres des données "mca"
#Utilisez la fonction fziz_screeplot() pour obtenir le screeplot des valeurs propres de "mca"





4.2
#Visualisons comment nos variables sont en corrélation avec la fonction fziz_mca_var().
#Appliquez-le à vos données "mca"
#Nous allons examiner la corrélation, alors définissez Choice = "mca.cor"
#Vous pouvez modifier le titre de n'importe quel graphique en définissant title="votre titre ici"
#Vous pouvez voir que ces valeurs correspondent aux valeurs R^2 du
#2 premières dimensions obtenues à partir de la fonction dimdesc(mca)






4.3
#Visualisons cette contribution de chaque variable dans notre prochain graphique !
#Utilisez la fonction fziz_mca_biplot() avec col.var = "contrib", et étiquetez le
#dégradé de couleurs avec la commande gradient.cols=
#Jouez avec cette fonction pour trouver ce qui représente le mieux vos données







4.4
#Maintenant, nous avons étudié les variables
#Jetons un coup d'oeil à la façon dont nos individus se situent dans ces variables!
#Tout d'abord, choisissez une variable qui vous intéresse le plus
#Ensuite, sous-définissez cette colonne en tant que vecteur
#changez-le en facteur
#enregistre-le sous grp
grp <- 




#Nous pouvons maintenant utiliser le fviz_mca_biplot pour visualiser comment les individus sont dispersés dans ce
#variable, en ajoutant :
#habillage = grp, addEllipses = TRUE, ellipse.level = 0.95






#Parfait! Votre analyse est maintenant terminée

#################################################################################################

#In your presentation, include the figures and the tables of following:

4.1 #Scree Plot and its interpretation
4.3 #A BiPlot with contrib-values, and interpretation
4.4 #A Biplot with cluster analysis of how the subjects cluster around
#the variables & interpretation

#################################################################################################
