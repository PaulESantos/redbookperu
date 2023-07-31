############################################################################
############################################################################
####                                                                     ###
####                       COMPUTE_ENDEMISM_WCVP.R                       ###
####                        AUTHOR: STUART ALLEN                         ###
####                       Modified by PAUL SANTOS                       ###
####                          DATE: AUGUST 2022                          ###
####                                                                     ###
############################################################################
############################################################################
#
###
### PURPOSE:
### Compute endemism for botanical countries using data from the
### World Checklist of Vascular Plants (WCVP)
###
### Execution time: 1-2 minutes
#
#library(tidyverse)
#
#rm(list = ls())
#
## regular expression to check taxon names conform to "valid" taxon name
## thus remove hybrids etc.
#regexValidTaxon <- "^[A-Z][a-z\\-]+ [a-z\\-]+( (subsp|var|f|subvar)\\. [a-z\\-]+)?$"
#
## regular expression to check all truncated species names are valid to genus & species
#regexValidSpecies <- "^[A-Z][a-z\\-]+ [a-z\\-]+$"
#
## load WCVP data on taxon names
## note that these data (and the distribution data below) are not comma-separated,
## the docs on the website suggest the following code to read the files,
## i.e., read.table() rather than read_csv()
#
#wcvpNames <-
#  #read.table("data/wcvp/wcvp_names.txt", sep = "|", header = TRUE,
#  #quote = "", fill = TRUE, encoding = "UTF-8") %>%
#  rWCVPdata::wcvp_names |>
#  filter(
#    # accepted names only
#    taxon_status == "Accepted",
#    # valid taxon ranks only
#    taxon_rank %in% c(
#      "Form",
#      "Species",
#      "Subspecies",
#      "Subvariety",
#      "Variety"
#    ),
#    grepl(regexValidTaxon, taxon_name)
#  ) %>%
#  mutate(
#    # create a column of taxon names that retain the species epithet only,
#    # i.e. remove infrarank from taxon name
#    taxon_name_species = str_extract(taxon_name, "^[A-Z][a-z\\-]+ [a-z\\-]+")
#  )
#
## load WCVP data on taxon distribution
## note that names and distribution data are linked via plant_name_id
#
#wcvpDistribution <-
#  #read.table("data/wcvp/wcvp_distribution.txt",
#  #           sep = "|", header = TRUE, quote = "",
#  #           fill = TRUE, encoding = "UTF-8") %>%
#  rWCVPdata::wcvp_distributions |>
#  filter(
#    # remove distribution records having no level 3 area code
#    area_code_l3 != "",
#    # remove if flagged as introduced, extinct or location doubtful
#    introduced == 0,
#    extinct == 0,
#    location_doubtful == 0
#  ) %>%
#  mutate(
#    # make a few corrections to obvious typos with level 3 area code
#    area_code_l3 = ifelse(area_code_l3 == "Ags", "AGS", area_code_l3),
#    area_code_l3 = ifelse(area_code_l3 == "bUL", "BUL", area_code_l3),
#    area_code_l3 = ifelse(area_code_l3 == "jap", "JAP", area_code_l3),
#    area_code_l3 = ifelse(area_code_l3 == "Tex", "TEX", area_code_l3)
#  )
#
## load botanical country definitions, i.e. which wgsrpd units comprise which
## botanical countries
#path_link <- "data/botanical_country_definitions.csv"
##bot <- read_csv("code/output/botanical_country_definitions.csv")
#bot <- readr::read_csv(path_link)
#
## # there is one bot code not in distribution data: remote Bouvet Is.
## setdiff(bot$wgsrpd_code, wcvpDistribution$area_code_l3)
## setdiff(wcvpDistribution$area_code_l3, bot$wgsrpd_code)
#
## generate list of species in each wgsrpd unit, with botanical country also
##
## here we are merging distribution data with accepted plant names and
## also botanical country
#
#speciesInWgsrpd <-
#  wcvpDistribution %>%
#  dplyr::select(
#    # we want the level 3 area code (equivalent to WGSRPD code) and taxon id
#    area_code_l3,
#    plant_name_id
#  ) |>
#  merge(
#    # merge with cleaned names, so will lose some rows from distribution for
#    # names that were removed as non-accepted or other reasons above
#    wcvpNames |>
#      dplyr::select(plant_name_id, taxon_name_species),
#    by = "plant_name_id", all.x = FALSE
#  ) |>
#  merge(
#    # merge with list of botanical countries
#    # note that wgsrpd units are in one and only one botanical country
#    bot |>
#      dplyr::select(wgsrpd_code, bot_code) |>
#      distinct(),
#    by.x = "area_code_l3",
#    by.y = "wgsrpd_code"
#  )
#
## # some of these distribution plant data will not be in our cleaned names
## # i.e., there is no distribution data for these
## unique(speciesInWgsrpd$plant_name_id) %>% length()
## unique(wcvpNames$plant_name_id) %>% length()
#
## list of species by botanical country
#
#botSpecies <-
#  speciesInWgsrpd %>%
#  dplyr::select(taxon_name = taxon_name_species, bot_code) %>%
#  dplyr::distinct() %>%
#  dplyr::arrange(bot_code, taxon_name) |>
#  dplyr::as_tibble()
#botSpecies
##saveRDS(botSpecies, "output/endemism_wcvp/bot_species.rds")
#
## determine endemism for each species with respect to botanical country
## i.e., how many bots does each species occur in?
#
#botsPerSpecies <-
#  botSpecies %>%
#  dplyr::group_by(taxon_name) %>%
#  dplyr::summarise(num_bots = dplyr::n())
#botsPerSpecies
## # unused elsewhere so no real need to save this
## write_csv(botsPerSpecies, "output/endemism_wcvp/species_bot_wcvp.csv")
#
## list of endemic species in each botanical country
#
#botEndemics <-
#  botSpecies |>
#  dplyr::filter(
#    # endemic species occur in one and only one botanical country
#    taxon_name %in% botsPerSpecies[botsPerSpecies$num_bots == 1, ]$taxon_name
#  )
#botEndemics |>
#  filter(bot_code == "PER")
##write_csv(botEndemics, "output/endemism_wcvp/bot_endemic_species.csv")
#
## count number of endemics per bot, first filter to endemics
## and summarise
#
#endemicsPerBot <-
#  botSpecies %>%
#  dplyr::filter(
#    taxon_name %in% botsPerSpecies[botsPerSpecies$num_bots == 1, ]$taxon_name
#  ) %>%
#  dplyr::group_by(bot_code) %>%
#  dplyr::summarise(num_endemics = dplyr::n())
#endemicsPerBot |>
#  dplyr::filter(bot_code == "PER")
## TODO:
## possible step here is to re-add in botanical countries with zero endemic species
## as these will not appear in this output, but this is not a necessary step
## so ignoring for the time being
#
## write WCVP endemism count for each botanical country
## used in compare_endemism.R
#
##write_csv(endemicsPerBot, "output/endemism_wcvp/endemism_bot_wcvp.csv")
#
## -------------------------------------------------------------------------
#endemic_of_peru <- botEndemics |>
#  filter(bot_code == "PER")
#endemic_of_peru
#species_endemic <- endemic_of_peru$taxon_name |>  unique()
#length(species_endemic)
#
#tnrs_endemic_species <- TNRS::TNRS(species_endemic,
#                                   sources = "wcvp")
#
#tnrs_endemic_species |>
#  save(file = "clean_data/wcvp_endemic_tnrs_validated.rda")
#botEndemics
#wcvp_endemic_peru <- botEndemics |>
#  filter(bot_code == "PER")
#
#wcvp_endemic_peru |>
#  save(file = "clean_data/wcvp_names_peru.rda")
#
