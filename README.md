
<!-- README.md is generated from README.Rmd. Please edit that file -->

# redbookperu

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/redbookperu)](https://CRAN.R-project.org/package=redbookperu)
[![Codecov test
coverage](https://codecov.io/gh/PaulESantos/redbookperu/branch/main/graph/badge.svg)](https://app.codecov.io/gh/PaulESantos/redbookperu?branch=main)
[![R-CMD-check](https://github.com/PaulESantos/redbookperu/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PaulESantos/redbookperu/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The `redbookperu` R package provides easy access to the data presented
in the Red Book of Endemic Plants of Peru (León et al., 2006), a
publication that compiles information about Peru’s endemic plant
species. The book encompasses detailed records of 5,508 taxa,
highlighting their distribution, taxonomic status, conservation
assessments, and ecological regions.

### Objective:

The main objective of `redbookperu` is to make the data from the Red
Book of Endemic Plants of Peru more accessible and useful for
researchers, botanists, ecologists, and anyone interested in studying
Peru’s unique and diverse flora. The dataset included in the redbookperu
package allows users to explore specific taxa information, examine their
geographic distribution, analyze their conservation status based on IUCN
criteria, and study their presence in various regions of Peru. By
providing a documented and user-friendly package, we aim to streamline
the process of accessing and analyzing the endemic plant data, thus
promoting further research and conservation efforts.

### Relevance:

The Red Book of Endemic Plants of Peru represents a significant resource
for understanding the distribution and conservation status of Peru’s
endemic plant species at the time of its publication. However, accessing
and working with the data from the original book can be challenging for
researchers, especially due to the large number of taxa and the need for
taxonomic standardization.

The `redbookperu` package addresses these challenges by first
standardizing the taxonomic names of the plant species using the
Taxonomic Name Resolution Service (TNRS) with the help of the World
Checklist of Vascular Plants (WCVP) database. This ensures consistent
and accurate naming conventions throughout the dataset, enhancing its
usability and reliability for research purposes.

By developing the `redbookperu` package, we aim to democratize access to
this essential botanical knowledge and foster more in-depth studies and
conservation initiatives focused on Peru’s endemic plants. Researchers
can now explore the data with ease, conduct spatial analyses, and gain a
better understanding of the ecological importance of Peru’s diverse and
unique flora.

We believe that by making this valuable information available to the
scientific community, we can strengthen biodiversity research, inform
conservation strategies, and contribute to a better understanding of the
ecological significance of Peru’s diverse plant species.

### Installation

You can install the development version of `redbookperu` from GitHub:

``` r
pak::pak("PaulESantos/redbookperu")
```
