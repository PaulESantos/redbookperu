# List of Species Names in redbook_sps_class Separated by Category

The `redbook_sps_class` dataset includes all species names separated by
genus, epithet, author, subspecies, variety, and their position (ID) in
the `redbook_tab`.

## Usage

``` r
redbook_sps_class
```

## Format

A data.frame with the following columns:

- species:

  A character vector. The full species name.

- genus:

  A character vector. The genus of the species.

- epithet:

  A character vector. The specific epithet of the species.

- input_subspecies_epitheton:

  A character vector. The infraspecific epithet of the species, if
  applicable.

- rank:

  A character vector. The taxonomic rank (e.g., "species", "subspecies",
  "variety").

- subspecies:

  A character vector. The subspecies name, if applicable.

- variety:

  A character vector. The variety name, if applicable.

- hybrid:

  A character vector. Indicates if the species is a hybrid.

- id:

  A character vector. The ID of the species in the `redbook_tab`.

## Examples

``` r

data("redbook_sps_class")
head(redbook_sps_class)
#>      species                genus      epithet       rank   subspecies variety
#> [1,] "ABATIA RUGOSA"        "ABATIA"   "RUGOSA"      "NULL" ""         ""     
#> [2,] "ABATIA SPICATA"       "ABATIA"   "SPICATA"     "NULL" ""         ""     
#> [3,] "ABUTILON AREQUIPENSE" "ABUTILON" "AREQUIPENSE" "NULL" ""         ""     
#> [4,] "ABUTILON LONGIPES"    "ABUTILON" "LONGIPES"    "NULL" ""         ""     
#> [5,] "ABUTILON PEDUNCULARE" "ABUTILON" "PEDUNCULARE" "NULL" ""         ""     
#> [6,] "ABUTILON PIURENSE"    "ABUTILON" "PIURENSE"    "NULL" ""         ""     
#>      hybrid id 
#> [1,] ""     "1"
#> [2,] ""     "2"
#> [3,] ""     "3"
#> [4,] ""     "4"
#> [5,] ""     "5"
#> [6,] ""     "6"
```
