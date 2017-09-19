source("F:/Ulli/exploratorien/scripts/00_set_environment.R")
library(mboost)

# - PLS Training ----------------------------------------------------------------------------
# training LUI starts with 35 models
LUI <- readRDS(file = paste0(path_rdata, "LUImodel.rds"))
for(be in names(LUI)){
  act_gpm_selected <- LUI[[be]]
  
  act_gpm_selected <- trainModel(x = act_gpm_selected,
                                 n_var = NULL,             
                                 mthd = "pls",
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",
                                 response_nbr = 18,
                                 filepath_tmp = path_temp
                                 )
  saveRDS(act_gpm_selected, file = paste0(path_results, "pls_ffs_LUI_", be, ".rds"))
  
  LUI[[be]] <- act_gpm_selected
}
saveRDS(LUI, file = paste0(path_results, "pls_ffs_LUI.rds"))

LUPLS<-readRDS(paste0(path_results, "pls_ffs_LUI.rds"))
# RF
for(be in names(LUPLS)){
  act_gpm_selected <- LUPLS[[be]]
  
  act_gpm_selected <- trainModel(x = act_gpm_selected,
                                 n_var = NULL,             
                                 mthd = "rf",
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",

  
  LUPLS[[be]] <- act_gpm_selected
}
saveRDS( LUPLS, file = paste0(path_results, "rf_ffs_LUI.rds"))

LUPLS<-rfLu 
for(be in names(LUPLS)){
  act_gpm_selected <- LUPLS[[be]]
  
  act_gpm_selected <- trainModel(x = act_gpm_selected,
                                 n_var = NULL,             
                                 mthd = "gam",                      #richtige Auswählen!
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",
                                 response_nbr = 18,
                                 filepath_tmp = path_temp
                                 )
  saveRDS(act_gpm_selected, file = paste0(path_results, "GAM_ffs_LUI_", be, ".rds"))
  
  LUPLS[[be]] <- act_gpm_selected
}
saveRDS(LUPLS, file = paste0(path_results, "GAM_ffs_LUI.rds"))

###have to join the spec.rich GLM Model (from lenovo)

#SpecRich
SPECRICH <- readRDS(file = paste0(path_rdata, "SPECmodel.rds"))
for(be in names(SPECRICH)){
  act_gpm_selected <- SPECRICH[[be]]
  
  act_gpm_selected <- trainModel(x = act_gpm_selected,
                                 n_var = NULL,             
                                 mthd = "pls",
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",
                                 response_nbr = 1,
                                 filepath_tmp = path_temp
  )
  saveRDS(act_gpm_selected, file = paste0(path_results, "pls_ffs_SPECRICH_", be, ".rds"))
  
  SPECRICH[[be]] <- act_gpm_selected
}
saveRDS(SPECRICH, file = paste0(path_results, "pls_ffs_SPECRICH.rds"))


# - RF Training ------------------------------------------------------------------------------
#SpecRich
  act_gpm_selected <- trainModel(x = act_gpm_selected[[be]],
                                 n_var = NULL,             
                                 mthd = "rf",
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",
                                 response_nbr = 1,
                                 filepath_tmp = path_temp
  )
  saveRDS(act_gpm_selected, file = paste0(path_results, "rf_ffs_SPECRICH_", be, ".rds"))
  
  SPECRICH[[be]] <- act_gpm_selected

saveRDS(SPECRICH, file = paste0(path_results, "rf_ffs_SPECRICH.rds"))

# - GAM Training -----------------------------------------------------------------------------
# check unique predictor values before running (must be 10!)

#SpecRich
SPECRICH <- readRDS(file = paste0(path_rdata, "SPECmodel.rds"))
for(be in names(SPECRICH)){
  act_gpm_selected <- SPECRICH[[be]]
  
  act_gpm_selected <- trainModel(x = act_gpm_selected,
                                 n_var = NULL,             
                                 mthd = "gam",                      #richtige Auswählen!
                                 mode = "ffs",
                                 seed_nbr = 11, 
                                 cv_nbr = 5,
                                 var_selection = "indv",
                                 response_nbr = 1,
                                 filepath_tmp = path_temp
  )
  saveRDS(act_gpm_selected, file = paste0(path_results, "gam_ffs_SPECRICH_", be, ".rds"))
  
  SPECRICH[[be]] <- act_gpm_selected
}
saveRDS(SPECRICH, file = paste0(path_results, "gam_ffs_SPECRICH.rds"))

