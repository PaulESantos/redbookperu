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

A tibble containing comprehensive information about the provided
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
#> # A tibble: 3 × 16
#>   name_submitted        name_subitted         accepted_name accepted_name_author
#>   <chr>                 <chr>                 <chr>         <chr>               
#> 1 Aphelandra cuscoensis Aphelandra cuscoensis Aphelandra c… Wassh.              
#> 2 Sanchezia ovata       Sanchezia ovata       Sanchezia ov… Ruiz & Pav.         
#> 3 Piper stevensii       Piper stevensii       Piper steven… Trel.               
#> # ℹ 12 more variables: accepted_family <chr>, redbook_name <chr>, iucn <chr>,
#> #   publication <chr>, collector <chr>, herbariums <chr>, common_name <chr>,
#> #   dep_registry <chr>, ecological_regions <chr>, sinampe <chr>,
#> #   peruvian_herbariums <chr>, remarks <chr>
```
