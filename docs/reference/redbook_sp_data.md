# Database of the Red Book of Endemic Plants of Peru

This database contains comprehensive information regarding the endemic
plant species listed in the Red Book of Endemic Plants of Peru. Each
endemic taxon is accompanied by corresponding variables that detail its
taxonomic status, IUCN conservation category, bibliographic references,
type collection details, common names, departmental registrations,
ecological regions, protected natural areas (SINANPE), and Peruvian
herbaria where the specimens are deposited, as recorded in the original
book.

## Usage

``` r
redbook_sp_data
```

## Format

A data frame with the following variables:

- redbook_id:

  Unique identifier for each species in the Red Book of Endemic Plants
  of Peru.

- redbook_name:

  Scientific name of the endemic species.

- iucn:

  Conservation category assigned according to IUCN.

- publication:

  Bibliographic reference where the taxon was originally described.

- collector:

  Name(s) of the collector(s) of the type specimen.

- herbariums:

  Acronyms of the institutions where the type specimens of the taxon are
  deposited.

- common_name:

  Common names of the species as mentioned in the literature.

- dep_registry:

  Abbreviations of the departments where the taxon has been recorded.

- ecological_regions:

  Abbreviations of the ecological regions proposed by Zamora (1996).

- sinampe:

  Abbreviation of the Protected Natural Area where the taxon was
  recorded.

- peruvian_herbariums:

  Acronyms of the Peruvian institutions where both type and non-type
  specimens are deposited.

- remarks:

  Observations and additional information about the endemic taxon.

## Details

This database provides essential information for research and
conservation efforts related to Peru's endemic flora, offering access to
the data presented in the corresponding book.

## References

León, Blanca, et.al. 2006. “The Red Book of Endemic Plants of Peru”.
Revista Peruana De Biología 13 (2): 9s-22s.
https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153

## Examples

``` r

# Example illustrating how to load and explore the database
data("redbook_sp_data")
head(redbook_sp_data)
#> # A tibble: 6 × 12
#>   redbook_id redbook_name     iucn  publication collector herbariums common_name
#>   <chr>      <chr>            <chr> <chr>       <chr>     <chr>      <chr>      
#> 1 1APCU      Aphelandra cusc… EN, … Phytologia… C. Varga… (US)       Desconocid…
#> 2 2APHA      Aphelandra hapa… CR, … Phytologia… R. Ferre… NA         Desconocid…
#> 3 3APJU      Aphelandra juni… CR, … Phytologia… A. Weber… NA         Desconocid…
#> 4 4APLA      Aphelandra lati… VU, … Phytologia… R. Ferre… NA         Desconocid…
#> 5 5APVI      Aphelandra visc… EN, … Repert. Sp… A. Raimo… (B)        Desconocid…
#> 6 6APWE      Aphelandra webe… EN, … Notizbl. B… A. Weber… NA         Desconocid…
#> # ℹ 5 more variables: dep_registry <chr>, ecological_regions <chr>,
#> #   sinampe <chr>, peruvian_herbariums <chr>, remarks <chr>
```
