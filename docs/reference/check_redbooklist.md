# Check Species Names in the Red Book of Endemic Plants of Peru

This function checks a list of species names against the Red Book of
Endemic Plants of Peru database and provides information about whether a
species was recorded as endemic, and checks for misspelling typos (fuzzy
match).

## Usage

``` r
check_redbooklist(
  splist,
  dist = 0.02,
  output = c("status", "detailed"),
  quiet = FALSE
)
```

## Arguments

- splist:

  A character vector containing the species names to be checked.

- dist:

  Maximum allowed distance for fuzzy matching of species names.

- output:

  Output type. `"status"` returns the legacy character vector;
  `"detailed"` returns row-level matching diagnostics.

- quiet:

  If `TRUE`, suppresses summary messages.

## Value

With `output = "status"`, a character vector indicating whether each
input name is listed as endemic. With `output = "detailed"`, a tibble
with row-level matching diagnostics.

## Details

This function checks each species name in the provided list against the
Red Book of Endemic Plants of Peru database using fuzzy matching based
on the specified maximum distance (`dist`). It provides information
about the endemic status of each species and flags if the recorded name
needs updating. It also counts the number of exact and fuzzy matches
found.

## References

[Red Book of Endemic Plants of
Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
[The World Checklist of Vascular Plants, a continuously updated resource
for exploring global plant
diversity.](https://www.nature.com/articles/s41597-021-00997-6#citeas)
[Taxonomic Name Resolution Service - TNRS](https://tnrs.biendata.org/)
[Plants of the World Online - Facilitated by the Royal Botanic Gardens -
Kew.](http://www.plantsoftheworldonline.org/)

## Examples

``` r
# Example usage of the function
splist <- c("Aphelandra cuscoenses",
            "Piper stevensi",
            "Sanchezia ovata",
            "Verbesina andina",
            "Festuca dentiflora",
            "Eucrosia bicolor var. plowmanii",
            "Hydrocotyle bonplandii var. hirtipes",
            "Persea americana")

# Basic usage
check_redbooklist(splist = splist, dist = 0.2)
#> Total exact matches: 5
#> Total fuzzy matches: 2
#> [1] "endemic"     "endemic"     "endemic"     "endemic"     "endemic"    
#> [6] "endemic"     "endemic"     "not endemic"

# Using base R with a data frame
plant_list <- data.frame(splist = splist)
plant_list$label <- check_redbooklist(plant_list$splist, dist = 0.2)
#> Total exact matches: 5
#> Total fuzzy matches: 2
plant_list
#>                                 splist       label
#> 1                Aphelandra cuscoenses     endemic
#> 2                       Piper stevensi     endemic
#> 3                      Sanchezia ovata     endemic
#> 4                     Verbesina andina     endemic
#> 5                   Festuca dentiflora     endemic
#> 6      Eucrosia bicolor var. plowmanii     endemic
#> 7 Hydrocotyle bonplandii var. hirtipes     endemic
#> 8                     Persea americana not endemic
```
