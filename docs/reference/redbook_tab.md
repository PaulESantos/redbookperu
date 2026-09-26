# Species Names Listed in The Red Book of Endemic Plants of Peru

The `redbook_tab` contains records for all species listed in The Red
Book of Endemic Plants of Peru.

## Usage

``` r
redbook_tab
```

## Format

A tibble with the following columns:

- redbook_id:

  The fixed species ID of the input taxon in The Red Book of Endemic
  Plants of Peru.

- redbook_name:

  A character vector. The species name as listed in The Red Book of
  Endemic Plants of Peru.

- input_genus:

  A character vector. The input genus of the corresponding species name
  listed.

- input_epitheton:

  A character vector. The specific epithet of the corresponding species
  name listed.

- rank:

  A character vector. The taxonomic rank (e.g., "species", "subspecies",
  "variety") of the corresponding species name listed.

- input_subspecies_epitheton:

  A character vector. The infraspecific epithet of the corresponding
  species name listed, if applicable.

- accepted_name:

  A character vector. The accepted plant taxa names according to the
  World Checklist of Vascular Plants (WCVP).

- accepted_family:

  A character vector. The corresponding family name of the accepted
  name.

- accepted_name_author:

  A character vector. The author of the accepted name.

- accepted_name_rank:

  A character vector. The rank of the accepted name (e.g., species,
  subspecies).

- tag_subsp_wcvp:

  A character vector. A tag indicating if the subspecies is recognized
  in the WCVP.

- genus_ephitethon_wcvp:

  A character vector. The genus part of the name according to the WCVP.

- species_ephitethon_wcvp:

  A character vector. The specific epithet part of the name according to
  the WCVP.

- subspecies_ephitethon_wcvp:

  A character vector. The infraspecific epithet part of the name
  according to the WCVP, if applicable.

- wcvp_matched_name:

  The taxon name matched in the WCVP backbone.

- wcvp_matched_author:

  The authors of the matched WCVP taxon.

- wcvp_taxon_status:

  The WCVP taxonomic status of the matched taxon.

- wcvp_matched_plant_name_id:

  The WCVP identifier of the matched taxon.

- accepted_plant_name_id:

  The WCVP identifier of the accepted taxon.

- wcvp_is_accepted_name:

  Whether the matched WCVP name is accepted.

- wcvp_matched:

  Whether WCVP returned a match.

- taxonomy_source:

  The source and reconciliation method used for the update.

- taxonomy_updated_at:

  UTC timestamp of the taxonomy update.

## References

León, Blanca, et.al. 2006. “The Red Book of Endemic Plants of Peru”.
Revista Peruana De Biología 13 (2): 9s-22s.
https://doi.org/10.15381/rpb.v13i2.1782.

## Examples

``` r

data("redbook_tab")
head(redbook_tab)
#> # A tibble: 6 × 23
#>   redbook_id redbook_name         input_genus input_epitheton rank 
#>   <chr>      <chr>                <chr>       <chr>           <chr>
#> 1 2359ABRU   Abatia rugosa        Abatia      rugosa          null 
#> 2 2360ABSP   Abatia spicata       Abatia      spicata         null 
#> 3 2859ABAR   Abutilon arequipense Abutilon    arequipense     null 
#> 4 2860ABLO   Abutilon longipes    Abutilon    longipes        null 
#> 5 2861ABPE   Abutilon pedunculare Abutilon    pedunculare     null 
#> 6 2862ABPI   Abutilon piurense    Abutilon    piurense        null 
#> # ℹ 18 more variables: input_subspecies_epitheton <chr>, accepted_name <chr>,
#> #   accepted_family <chr>, accepted_name_author <chr>,
#> #   accepted_name_rank <chr>, tag_subsp_wcvp <chr>,
#> #   genus_ephitethon_wcvp <chr>, species_ephitethon_wcvp <chr>,
#> #   subspecies_ephitethon_wcvp <chr>, wcvp_matched_name <chr>,
#> #   wcvp_matched_author <chr>, wcvp_taxon_status <chr>,
#> #   wcvp_matched_plant_name_id <dbl>, accepted_plant_name_id <dbl>, …
```
