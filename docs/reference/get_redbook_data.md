# Get Red Book Data for Given Species List

This function retrieves comprehensive information from the Red Book of
Endemic Plants of Peru database for a provided list of species. It
associates the provided species names with their corresponding updated
taxonomic information and descriptions recorded in the original
publication.

## Usage

``` r
get_redbook_data(
  splist,
  dist = 0.1,
  unmatched = c("NA", "placeholder"),
  quiet = FALSE
)
```

## Arguments

- splist:

  A character vector containing the species names to be queried.

- dist:

  Maximum allowed distance for fuzzy matching of species names.

- unmatched:

  How unmatched or invalid rows are represented. `"NA"` uses missing
  values; `"placeholder"` uses the historical `"---"` placeholder.

- quiet:

  If `TRUE`, suppresses summary messages.

## Value

A data frame containing comprehensive information about the provided
species, including updated taxonomic details and descriptions.

## Details

This function checks each species name in the provided list against the
Red Book of Endemic Plants of Peru database using fuzzy matching based
on the specified maximum distance (`dist`). For each species, it
retrieves and combines taxonomic information (accepted name, accepted
family, accepted name author) with additional descriptive data recorded
in the original publication, such as IUCN conservation category,
bibliographic reference, collector, herbariums, common name,
departmental registrations, ecological regions, protected natural areas
(SINANPE), Peruvian herbaria, and additional remarks.

## References

[Red Book of Endemic Plants of
Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
[The World Checklist of Vascular Plants, a continuously updated resource
for exploring global plant
diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
[Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
[Plants of the World Online - Facilitated by the Royal Botanic Gardens -
Kew.](http://www.plantsoftheworldonline.org/)

## See also

[`check_redbooklist`](https://paulesantos.github.io/redbookperu/reference/check_redbooklist.md)
function for a more focused check of species endemic status.

## Examples

``` r
# Example illustrating how to use the get_redbook_data function
species_list <- c("Aphelandra cuscoensis", "Sanchezia ovata", "Piper stevensii")
redbook_data <- get_redbook_data(species_list)
#> Total exact matches: 2
#> Total fuzzy matches: 1
head(redbook_data)
#>          name_submitted         name_subitted         accepted_name
#> 1 Aphelandra cuscoensis Aphelandra cuscoensis Aphelandra cuscoensis
#> 2       Sanchezia ovata       Sanchezia ovata       Sanchezia ovata
#> 3       Piper stevensii       Piper stevensii       Piper stevensii
#>   accepted_name_author accepted_family          redbook_name    iucn
#> 1               Wassh.     Acanthaceae Aphelandra cuscoensis EN, B1a
#> 2          Ruiz & Pav.     Acanthaceae    Sanchezia capitata      DD
#> 3                Trel.      Piperaceae       Piper stevensii    <NA>
#>                                          publication           collector
#> 1                 Phytologia 25(7): 469 - 470. 1973.  C. Vargas C. 15415
#> 2        Bull. Herb. Boissier, ser. 2, 4: 315. 1904. A. Mathews 1230 (K)
#> 3 Field Mus. Nat. Hist., Bot. Ser. 13(2): 237. 1936.     F.L. Stevens 85
#>   herbariums  common_name dep_registry              ecological_regions
#> 1       (US) Desconocido.           CU                 BHA; 470—520 m.
#> 2       <NA> Desconocido.      JU - PA BMHP, BHA; altitud desconocida.
#> 3       ILL. Desconocido.           JU Sin datos; altitud desconocida.
#>        sinampe peruvian_herbariums
#> 1          PNM            CUZ (1).
#> 2 Sin registro            Ninguno.
#> 3 Sin registro            Ninguno.
#>                                                                                                                                                                                                                               remarks
#> 1                                                       Hierba terrestre conocida solamente del sur del país, de las cuencas del Marcapata y del Madre de Dios. Aparentemente no ha vuelto a ser recolectada desde la década de 1960.
#> 2 Esta especie arbustiva es conocida de dos localidades. La colección tipo fue recolectada en la cuenca del Pangoa en el siglo XVIII. Probablemente la expansión urbana y las actividades agrícolas sean problemas para esta especie.
#> 3                                                                                    Este taxón fue considerado por Brako & Zarucchi (1993) como un endemismo; sin embargo, no ha sido posible evaluarlo, ni asignarle una categoría.
```
