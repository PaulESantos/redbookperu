
<!-- README.md is generated from README.Rmd. Please edit that file -->

# redbookperu <a href='https://github.com/PaulESantos/redbookperu'><img src='man/figures/redbookperu_logo.png' align="right" height="250" width="220" /></a>

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
endemic plant species, encompassing records of 5,507 distinct taxa.
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
#> This is redbookperu 0.0.3
```

To determine if a species of interest is listed in the Red Book of
Endemic Plants of Peru, we provide the `check_redbooklist()` function.
This function verifies whether the species of interest is included in
the book’s species list.When the species of interest doesn’t match the
species list, the response is “Not endemic”.

``` r

splist <- c("Aphelandra cuscoenses", 
            "Sanchezia capitata",
            "Sanchezia ovata", 
            "Piper stevensi",
            "Verbesina andinaa", 
            "Verbesina andina", 
            "Weinmania nubigena")

redbookperu::check_redbooklist(splist, dist = 0.2)
#> Total exact matches: 2
#> Total fuzzy matches: 3
#> [1] "endemic"     "endemic"     "not endemic" "endemic"     "endemic"    
#> [6] "endemic"     "not endemic"
```

Function indicate the presence of partial matches (fuzzy match) when the
name of the species of interest varies compared to the information
present in the database.

`check_redbooklist()` function is designed to work seamlessly with
tibble, allowing users to easily analyze species data within a tabular
format.

``` r
tibble::tibble(splist = splist) |> 
  dplyr::mutate(endemic = redbookperu::check_redbooklist(splist,
                                                         dist = 0.2))
#> Total exact matches: 2
#> Total fuzzy matches: 3
#> # A tibble: 7 × 2
#>   splist                endemic    
#>   <chr>                 <chr>      
#> 1 Aphelandra cuscoenses endemic    
#> 2 Sanchezia capitata    endemic    
#> 3 Sanchezia ovata       not endemic
#> 4 Piper stevensi        endemic    
#> 5 Verbesina andinaa     endemic    
#> 6 Verbesina andina      endemic    
#> 7 Weinmania nubigena    not endemic
```

If you intend to access the information provided for each of the species
listed in the Red Book of Endemic Plants of Peru, you have the option to
use the `get_redbook_data()` function. This function facilitates the
association of updated taxonomic information with the details concerning
conservation status, distribution, and descriptions presented in the
original publication.

``` r
redbookperu::get_redbook_data(c("Sanchecia capitata",
                   "Weinmania nubigena",
                   "Macroclinium christensonii",
                   "Weberbauera violacea"), 
                   dist = 0.2)
#>                name_subitted              accepted_name accepted_name_author
#> 1         Sanchecia capitata                        ---                  ---
#> 2         Weinmania nubigena                        ---                  ---
#> 3 Macroclinium christensonii Macroclinium christensonii            D.E.Benn.
#> 4       Weberbauera violacea       Weberbauera violacea           Al-Shehbaz
#>   accepted_family               redbook_name        iucn
#> 1             ---                        ---         ---
#> 2             ---                        ---         ---
#> 3     Orchidaceae Macroclinium christensonii CR, B1abiii
#> 4    Brassicaceae       Weberbauera violacea          DD
#>                                publication                            collector
#> 1                                      ---                                  ---
#> 2                                      ---                                  ---
#> 3 Brittonia 46(3): 249 - 251, f. 13. 1994. O. del Castillo ex D.E. Bennett 5160
#> 4      Novon 14(3): 266 - 268, f. 3. 2004.        A. Sagástegui A. et al. 11175
#>   herbariums  common_name dep_registry ecological_regions      sinampe
#> 1        ---          ---          ---                ---          ---
#> 2        ---          ---          ---                ---          ---
#> 3        NY. Desconocido.           JU      BMHM; 1800 m. Sin registro
#> 4  MO; HUT!. Desconocido.           CA       PAR; 3800 m. Sin registro
#>   peruvian_herbariums
#> 1                 ---
#> 2                 ---
#> 3            Ninguno.
#> 4      HUT (isotipo).
#>                                                                                                                                                                                                                                             remarks
#> 1                                                                                                                                                                                                                                               ---
#> 2                                                                                                                                                                                                                                               ---
#> 3 Esta hierba epífita es conocida sólo de la colección tipo, proveniente del valle de Chanchamayo, en una subcuenca del Perené. Esta región ha sufrido continuas reducciones de sus áreas naturales debido a la ampliación de la frontera agrícola.
#> 4                                                            Esta hierba paramuna es conocida de la localidad tipo, en la cuenca del Crisnejas, un tributario del Marañón. El ejemplar tipo fue recolectado en 1983, de una jalca poco herborizada.
```

### Note:

The code for the new version of the `redbookperu` package is based on
the [`lcvplants`](https://idiv-biodiversity.github.io/lcvplants/)
package, with modifications specifically tailored to work with the data
from the Red Book of Endemic Plants of Peru.
