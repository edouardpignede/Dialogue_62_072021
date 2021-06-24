# Construction des indices au niveau des ports

## Indices considérés

Les indices de prix sont calculés suivant la méthode des ventes répétées présentée dans l'article. De plus, plusieurs paramètres ont été envisagés pour améliorer la qualité des données (valeur par défaut retenueentre parhenthèse ; T = Vrai, F = Faux) :
-	Outliers égal à T ou F (T) : Retire-t-on les outliers ?  Outliers d'une loi log-normale avec z-score modifié
-	Outliers_coef égal à un nombre positif (10) : Outliers_coef utilisé pour la détection des outliers, plus il est grand plus le nombre d'outliers diminue
-	Trans_number égal à un entier positif (0) : Retire les produits apparaissant moins de Trans_number fois dans la base filtrée ?
-	 Prod_problems égal à T ou F (F) : Retire-t-on les produits avec un écart interquartile (3rd - 1st quartile) supérieur à 10 ?
-	 Product_select égal à T ou F (F) : Conserve-t-on uniquement les produits de première nécéssité ?
-	Remove_double égal à T ou F (T) : Rassemble-t-on les produits vendus plus de deux fois dans la même année.
-	Ponderation égal à T ou F (T) : Pondère-t-on l'équation des ventes répétées par la part de la valeur du produit dans la valeur totale ?
-	Pond_log égal à T ou F (F) : Pondère-t-on l'équation des ventes répétées par le logarithme de la part de la valeur du produit dans la valeur totale ?

### Précision
##### Détection des outliers
Puisque nos données sont des prix, nous considérons qu’ils suivent une loi log-normale (distribution classique pour des suites de prix). En passant au log on se ramène donc à une loi normale. 
On a donc, Outliers = T lorsque le z-score modifié selon la méthode de Iglewicz et Hoaglin (1993) du log des prix est supérieur à Outliers_coef.
Un coefficient égakl à 1O revient à conserver environ 1% des valeurs pour une loi log-normale parfaite.

##### Produits problématiques
En observant les données, on constate que des erreurs d'unité entraînent régulièrement des différences de prix très importantes pour un même produits. On a par exemple deux unités mal corrigés pour un produit qui rend à des sauts importants entre les deux produits.


## Corrélations systématiques
Dans le fichier Excel *Correlation_matrix_parametres.xlsx*, on trouve pour chaque indice (un onglet par indice) les corrélations entre les indices de la baseline (valeurs des paramètres par défaut) et les indices où chaque paramètre a une valeur différente de la baseline.
En moyennant la valeur de ces corrélations sur l'ensemble des ports, on constate que les paramètres ayant un impact significatif sur le indices sont : Outliers, Product_select et Ponderation. Pour des raisons graphiques de stabilité des indices, ces paramètres ont été pris égal à T, F et T. Les autres paramètres ont été fixés aux valeurs permettant de maximiser la quantité de données utilisées dans la construction de l'indice.

 
 # Graphique des indices
 
 Dans le fichier *Figures_indices*, on trouve l'ensemble des représentations des indices d'importations et d'exportations pour les ports de Bordeaux, Marseille, Nantes, La Rochelle et Bayonne. L'axe de droite permet d'observer la part du commerce du port (imports ou exports) qui est prise en compte chaque année dans la construction de l'indice correspondant. Celle-ci est comprise en moyenne autour de 80%.
 
 









