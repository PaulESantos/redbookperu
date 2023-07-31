#ibrary(tidyverse)

# -------------------------------------------------------------------------
# -------------------------------------------------------------------------
#ed_bok <- readxl::read_excel("data/ppendemic_data.xlsx") |>
# dplyr::mutate(species_name = dplyr::if_else(species_name == "Suessenguthia vargasii var.hirsuta",
#                               "Suessenguthia vargasii var. hirsuta",
#                               species_name)) |>
# dplyr::mutate(species_name = simple_cap_vect(species_name))
#ed_bok |>  dim()
#ed_bok |>  names()
#edbook_species <- red_bok$species_name |>  unique()
#edbook_species |>  length()
#nrs_redbook <- TNRS::TNRS(redbook_species,
#                          sources = "wcvp")

#edbook_tab <- red_bok |>
# select(species_name,
#        iucn,
#        publication = publicacion,
#        collector = colector,
#        herbariums = herbarios,
#        common_name = nombre_comun,
#        dep_registry = registro_dep,
#        ecological_regions = regiones_ecologicas,
#        sinampe,
#        peruvian_herbariums = herbarios_peruanos,
#        remarks = observaciones
# ) |>
# mutate(dep_registry = tm::removePunctuation(dep_registry)|>
#          str_squish() |>
#          str_trim() |>
#          str_replace_all(" ", " - ")) |>
# mutate_if(is.character, ~ str_trim(.) |>  str_squish()) |>
# mutate(sinampe = tm::removePunctuation(sinampe) |>
#          str_replace_all(" ", " - ") |>
#          str_trim() |>
#          str_squish()) |>
# mutate(sinampe = if_else(sinampe == "Sin - registro",
#                          "Sin registro",
#                          sinampe))
#edbook_tab |>
# save(file = "data/readbook_tab.rda")

#edbook_tab |>
# names()




#edbook_tnrs <- redbook_tab |>
# left_join(tnrs_redbook |>
#             as_tibble() |>
#             select(Name_submitted, Name_matched,
#                    Accepted_family, Accepted_name, Accepted_name_author,
#                    Taxonomic_status),
#           by = c("species_name" = "Name_submitted")) |>
# janitor::clean_names()

#edbook_tnrs |>
# group_by(taxonomic_status) |>
# summarise(n = n_distinct(accepted_name))

#edbook_2 <- redbook_tnrs |>
# filter(taxonomic_status != "Accepted" ) |>
# mutate(species_name = accepted_name) |>
# select(-all_of(c("name_matched",
#                  "accepted_family",
#                  "accepted_name",
#                  "accepted_name_author",
#                  "taxonomic_status"    )))
#edbook_species_2 <- redbook_2$species_name |>  unique()
#ength(redbook_species_2)
#nrs_redbook <- TNRS::TNRS(redbook_species_2,
#                          sources = "wcvp")
#edbook_2 |>  dim()
#edbook_tnrs_2 <- redbook_2 |>
# left_join(tnrs_redbook |>
#             as_tibble() |>
#             select(Name_submitted, Name_matched,
#                    Accepted_family, Accepted_name, Accepted_name_author,
#                    Taxonomic_status),
#           by = c("species_name" = "Name_submitted")) |>
# janitor::clean_names()

#ind_rows(
#edbook_tnrs |> mutate(fuente = "redbook_original"),
#edbook_tnrs_2 |> mutate(fuente = "non_accepted_names")
#

#edbook_tnrs |>
# filter(str_detect(accepted_name,"Lantana x armata") ) |>
# select(species_name, accepted_name, taxonomic_status)
#ritexl::write_xlsx("data/tnrs_read_book_base.xlsx")

#f <- readxl::read_excel("data/tnrs_read_book_base_2.xlsx")

# porcentaje de errore ortograficos

#f |>
# mutate(ortografia = if_else(ortografia != "error ortografico",
#                             NA_character_,
#                             "error")) |>
# filter(fuente == "redbook_original") |>
# filter(ortografia == "error")

# distribucion de  del estado de las especies
#f |>
# filter(fuente == "redbook_original") |>
# group_by(taxonomic_status) |>
# summarise(n = n(),
#           .groups = "drop") |>
# mutate(porcent = 100*(n/sum(n))) |>
# janitor::adorn_totals()


#f |>
# add_count(species_name) |>
#writexl::write_xlsx("data/tnrs_read_book_base_2.xlsx")




#pendemic_data_names <- df |>
# select(species_name, name_matched, accepted_name,
#        accepted_family, accepted_name_author,
#        taxonomic_status) |>
# pivot_longer(-c("accepted_name",
#                 "accepted_family",
#                 "accepted_name_author",
#                 "taxonomic_status"),
#              values_to = "possible_names",
#              names_to = "name") |>
# #summarise(n = n_distinct(accepted_name))
# select(-name) |>
# filter(!is.na(possible_names)) |>
# distinct() |>
# mutate(taxon_name = paste0(accepted_name,
#                            " ",
#                            accepted_name_author)) |>
# relocate(possible_names)
#pendemic_names  <- ppendemic_data_names
#pendemic_names |>
# save(file = "data/ppendemic_names.rda")

#pendemic_names |>
#ummarise(n_accepted_name = n_distinct(accepted_name),
#           n_posible_names = n_distinct(possible_names))


# df |>
#   select(species_name, name_matched, accepted_name,
#          accepted_family, accepted_name_author,
#          taxonomic_status) |>
#   distinct() |>
#   summarise(n = n_distinct(accepted_name))

#pendemic_names |>
#utate( species_name_flag = case_when(
#   str_detect(accepted_name, "var\\.") ~ "variedad",
#   str_detect(accepted_name, "subsp\\.") ~ "subespecie",
#   TRUE ~ "specie"
# )) |>
# group_by(species_name_flag) |>
# summarise(n = n_distinct(accepted_name)) |>
# janitor::adorn_totals()
# -------------------------------------------------------------------------


# mutate(species_name_flag = case_when(
#   str_detect(species_name, "var\\.") ~ "variedad",
#   str_detect(species_name, "subsp\\.") ~ "subespecie",
#   TRUE ~ "specie"
# ),
# accepted_name_flag = case_when(
#   str_detect(accepted_name, "var\\.") ~ "variedad",
#   str_detect(accepted_name, "subsp\\.") ~ "subespecie",
#   TRUE ~ "specie"
# )
#          ) |>
# writexl::write_xlsx("data/tnrs_read_book_base_2.xlsx")

#nrs_redbook |>
# as_tibble() |>
# summarise(n = n_distinct(Accepted_name),
#           n_submitted = n_distinct(Name_submitted))


#nrs_redbook |>
# as_tibble() |>
# group_by(Accepted_name) |>
# summarise(n = n_distinct(Name_submitted)) |>
# filter(n == 3)
# arrange(desc(n)) |>
# count(n)


#nrs_redbook |>
# as_tibble() |>
# filter(Accepted_name == "Cumulopuntia boliviana subsp. boliviana" ) |>
# select(Name_submitted, Accepted_name, Accepted_family)


