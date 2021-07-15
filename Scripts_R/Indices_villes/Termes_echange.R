
### Chargement des différents packages utilisés
### S'ils ne sont pas installés sur la machine, procéder à leur installation 
### via la commande install.packages("nom_du_package")

library(dplyr)
library(tidyverse)
library(stringr)
library(readr)
library(pracma)


library(openxlsx)

library(hpiR)


### Nettoyage de l'espace de travail
rm(list = ls())




### Calcul du terme de l'échange uniquement pour la baseline :
# Outliers = T,
# Outliers_coef = 10,
# Trans_number = 0,
# Prod_problems = F,
# Product_select = F,
# Remove_double = T,
# Ponderation = T,
# Pond_log = F


Calcul_termes_echange <- function() 

{
  ### On charge les onnées d'index 
  Index_res <- read.csv2("./Bases_de_donnees_finales/Indices_villes/Index_results.csv", row.names = NULL, dec = ",")
  
  
  Index_res <- Index_res %>%
    ### On conserve uniquement la baseline
    filter(Outliers == T & Outliers_coef == 10 & Trans_number == 0 & Prod_problems == F &
             Product_select == F & Remove_double == T & Ponderation == T & Pond_log == F) %>%
    ### On garde seulement les colonnes d'indices permettant le calcul du terme de l'échange
    select(c("Ville", "Exports_imports", "year", "Index_value"))
  
  ### On reshape le dataframe : c'est à dire que l'on crée deux colonnes Imports et Exports issues de la colonne Exports_imports
  Index_res_reshape <- spread_(Index_res, key = "Exports_imports", value = "Index_value")
  
  
  Termes_echange_res <- Index_res_reshape %>%
    ### Calcul du termes de l'échange
    mutate(Termes_echange_value = Exports / Imports) %>%
    ### On conserve uniquement les colonnes d'intérêt
    select("Ville", "year", "Termes_echange_value") %>%
    mutate_if(is.character, as.factor)
  
  ### On écrit le csv résultant
  write.csv2(Termes_echange_res,
             "./Bases_de_donnees_finales/Indices_villes/Termes_echange_results.csv",
             row.names = F)
  
  
  for (Ville_cons in levels(Termes_echange_res$Ville)) {
    
    
    Terme_echange <- Termes_echange_res %>% 
      filter(Ville == Ville_cons) %>%
      select(c("year", "Termes_echange_value"))
  
    ### Ouverture du fichier d'écriture de figure
    png(filename = paste0("./Figures/Termes_echange/Ports/Termes_echange_", Ville_cons, ".png"),
        width = 5000,
        height = 2700,
        res = 500)
    
    ### Plot de la figure
    plot(drop_na(Terme_echange), main = Ville_cons, type = "o", ylim = c(0.75, 4))
    
    
    ### Enregistrementy de la figure
    dev.off()
    
  }   
  
}
