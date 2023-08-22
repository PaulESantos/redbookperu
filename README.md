
<!-- README.md is generated from README.Rmd. Please edit that file -->

# redbookperu <a href='https://github.com/PaulESantos/redbookperu'><img src='man/figures/cover_ppendemic.jpg' align="right" height="250" width="170" /></a>

<!-- badges: start -->

[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-green.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![CRAN
status](https://www.r-pkg.org/badges/version/redbookperu)](https://CRAN.R-project.org/package=redbookperu)
[![Codecov test
coverage](https://codecov.io/gh/PaulESantos/redbookperu/branch/main/graph/badge.svg)](https://app.codecov.io/gh/PaulESantos/redbookperu?branch=main)
[![R-CMD-check](https://github.com/PaulESantos/redbookperu/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/redbookperu/actions/workflows/R-CMD-check.yaml)
[![](http://cranlogs.r-pkg.org/badges/grand-total/redbookperu?color=green)](https://cran.r-project.org/package=redbookperu)
[![](http://cranlogs.r-pkg.org/badges/last-week/redbookperu?color=green)](https://cran.r-project.org/package=redbookperu)
<!-- badges: end -->

The R package `redbookperu` provides convenient access to the
information contained in the [Red Book of Endemic Plants of
Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153).
This book represents a comprehensive compilation of data on Peru’s
endemic plant species, encompassing records of 5,508 distinct taxa.
Although this document marked a milestone by consolidating an ambitious
initiative focused on understanding the diversity of Peru’s endemic
plant species at the time of its publication, it currently requires a
review and update of the presented taxonomic information.

The process of accessing data from the original publication can pose
challenges for researchers, particularly due to the large number of taxa
presented within it. The `redbookperu` package has the primary objective
of addressing these challenges by providing updated taxonomic
information. Additionally, it introduces functions designed to enhance
the accessibility and usefulness of the data presented in the Red Book
of Endemic Plants of Peru.

The information included in the `redbookperu` package is built with the
support of the [Taxonomic Name Resolution Service
TNRS](https://tnrs.biendata.org/), in collaboration with the [World
Checklist of Vascular Plants
WCVP](https://powo.science.kew.org/about-wcvp) database. These resources
are utilized to ensure the validity and standardization of the taxonomic
information that we provide.

### Installation

You can install the `redbookperu` package from CRAN using:

``` r
install.packages("redbookperu")

# or

pak::pak("redbookperu")
```

You can install the development version of `redbookperu` from GitHub:

``` r
pak::pak("PaulESantos/redbookperu")
```

### Getting Started

After installing the `redbookperu` package, you can load it into your R
session using:

``` r
library(redbookperu)
#> This is redbookperu 0.0.0.2
```

To determine if a species of interest is listed in the Red Book of
Endemic Plants of Peru, we provide the `check_redbook()` function. This
function verifies whether the species of interest is included in the
book’s species list. The function comes in two variations:

- `check_redbook(splist, tax_status == TRUE)`: The resulting information
  is structured as follows: “species name” - “taxonomic status” -
  “validation information”.
  - Species Name: Provides the currently accepted name for the species.
  - Taxonomic Status: Includes the following categories: “Accepted name”
    when the species name recorded remains valid currently, “Updated
    name” for species whose scientific name recorded at the time of
    publication is now considered synonymous, “No opinion” for species
    whose name presents difficulties in determining their current
    taxonomic status, and “Non info. available” for species for which
    updated information hasn’t been found in the WCVP database. When the
    species of interest doesn’t match the species list, the response is
    “Not endemic”.

``` r

splist <- c("Aphelandra cuscoenses", "Sanchezia capitata",
            "Sanchezia ovata", "Piper stevensi",
            "Verbesina andinaa", "Verbesina andina", "Weinmania nubigena")

check_redbook(splist, tax_status = TRUE)
#> [1] "Aphelandra cuscoensis - Accepted name - Fuzzy match"
#> [2] "Sanchezia ovata - Updated name"                     
#> [3] "Sanchezia ovata - Accepted name"                    
#> [4] "Piper stevensii - No opinion - Fuzzy match"         
#> [5] "Verbesina andina - No info. available - Fuzzy match"
#> [6] "Verbesina andina - No info. available"              
#> [7] "Weinmania nubigena - Not endemic"
```

- `check_redbook(splist, tax_status == FALSE)`: The result indicates
  whether the species is endemic or not, based on its match with the
  species present in the database.

``` r
check_redbook(splist, tax_status = FALSE)
#> [1] "Endemic - fuzzy match" "Endemic"               "Endemic"              
#> [4] "Endemic - fuzzy match" "Endemic - fuzzy match" "Endemic"              
#> [7] "Not endemic"
```

Both functions indicate the presence of partial matches (fuzzy match)
when the name of the species of interest varies compared to the
information present in the database.

`check_redbook()` function is designed to work seamlessly with tibbles,
allowing users to easily analyze species data within a tabular format.

``` r
tibble::tibble(splist = splist) |> 
  dplyr::mutate(endemic_tax_status = check_redbook(splist, tax_status = TRUE),
                endemic = check_redbook(splist, tax_status = FALSE))
```

``` r
# A tibble: 7 × 3
  splist                endemic_tax_status                                  endemic              
  <chr>                 <chr>                                               <chr>                
1 Aphelandra cuscoenses Aphelandra cuscoensis - Accepted name - Fuzzy match Endemic - fuzzy match
2 Sanchezia capitata    Sanchezia ovata - Updated name                      Endemic              
3 Sanchezia ovata       Sanchezia ovata - Accepted name                     Endemic              
4 Piper stevensi        Piper stevensii - No opinion - Fuzzy match          Endemic - fuzzy match
5 Verbesina andinaa     Verbesina andina - No info. available - Fuzzy match Endemic - fuzzy match
6 Verbesina andina      Verbesina andina - No info. available               Endemic              
7 Weinmania nubigena    Weinmania nubigena - Not endemic                    Not endemic   
```

If you intend to access the information provided for each of the species
listed in the Red Book of Endemic Plants of Peru, you have the option to
use the `get_redbook_data()` function. This function facilitates the
association of updated taxonomic information with the details concerning
conservation status, distribution, and descriptions presented in the
original publication.

``` r
get_redbook_data(c("Sanchecia capitata",
                   "Weinmania nubigena",
                   "Macroclinium christensonii",
                   "Weberbauera violacea"))
#>                name_subitted              accepted_name accepted_family
#> 1         Sanchecia capitata            Sanchezia ovata     Acanthaceae
#> 2         Weinmania nubigena                       nill            nill
#> 3 Macroclinium christensonii Macroclinium christensonii     Orchidaceae
#> 4       Weberbauera violacea       Weberbauera violacea    Brassicaceae
#>   accepted_name_author               redbook_name        iucn
#> 1          Ruiz & Pav.         Sanchezia capitata          DD
#> 2                 nill                       nill        nill
#> 3            D.E.Benn. Macroclinium christensonii CR, B1abiii
#> 4           Al-Shehbaz       Weberbauera violacea          DD
#>                                   publication
#> 1 Bull. Herb. Boissier, ser. 2, 4: 315. 1904.
#> 2                                        nill
#> 3    Brittonia 46(3): 249 - 251, f. 13. 1994.
#> 4         Novon 14(3): 266 - 268, f. 3. 2004.
#>                              collector herbariums  common_name dep_registry
#> 1                  A. Mathews 1230 (K)       <NA> Desconocido.      JU - PA
#> 2                                 nill       nill         nill         nill
#> 3 O. del Castillo ex D.E. Bennett 5160        NY. Desconocido.           JU
#> 4        A. Sagástegui A. et al. 11175  MO; HUT!. Desconocido.           CA
#>                ecological_regions      sinampe peruvian_herbariums
#> 1 BMHP, BHA; altitud desconocida. Sin registro            Ninguno.
#> 2                            nill         nill                nill
#> 3                   BMHM; 1800 m. Sin registro            Ninguno.
#> 4                    PAR; 3800 m. Sin registro      HUT (isotipo).
#>                                                                                                                                                                                                                                             remarks
#> 1               Esta especie arbustiva es conocida de dos localidades. La colección tipo fue recolectada en la cuenca del Pangoa en el siglo XVIII. Probablemente la expansión urbana y las actividades agrícolas sean problemas para esta especie.
#> 2                                                                                                                                                                                                                                              nill
#> 3 Esta hierba epífita es conocida sólo de la colección tipo, proveniente del valle de Chanchamayo, en una subcuenca del Perené. Esta región ha sufrido continuas reducciones de sus áreas naturales debido a la ampliación de la frontera agrícola.
#> 4                                                            Esta hierba paramuna es conocida de la localidad tipo, en la cuenca del Crisnejas, un tributario del Marañón. El ejemplar tipo fue recolectado en 1983, de una jalca poco herborizada.
```
