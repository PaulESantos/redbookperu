# List of the number positions of the first 3 letters of the species name in the redbook_tab

The 'redbook_position' reports the position (in term of number of rows)
of the first three letters (triphthong) for the plant names stored in
the variable 'accepted_name' of the table 'redbook_tab'. This indexing
system speeds up of the search on the largest list using the package.

## Usage

``` r
redbook_position
```

## Format

A data frame with 978 observations on the following 3 variables:

- position:

  A character vector. The position of the first three letters of the
  species name in the `redbook_tab`.

- triphthong:

  A character vector. The first three letters of the species name in the
  `redbook_tab`.

- genus:

  A character vector. The corresponding genus name.

## Details

Positions of Species Names in The Red Book of Endemic Plants of Peru

The `redbook_position` dataset provides the positions of the first three
letters of each species name listed in the `redbook_tab`.

## Examples

``` r

data("redbook_position")
head(redbook_position)
#>   position triphthong       genus
#> 1        1        ABA      ABATIA
#> 2        3        ABU    ABUTILON
#> 3        7        ACA      ACACIA
#> 4        8        ACA    ACALYPHA
#> 5       14        ACA ACAULIMALVA
#> 6       24        ACC        ACCA
```
