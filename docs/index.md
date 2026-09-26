# redbookperu [![](reference/figures/redbookperu_logo.png)](https://github.com/PaulESantos/redbookperu)

`redbookperu` provides access to the 5,507 taxa documented in the [Red
Book of Endemic Plants of
Peru](https://revistasinvestigacion.unmsm.edu.pe/index.php/rpb/issue/view/153)
(Leon et al., 2006), together with taxonomic reconciliation against the
World Checklist of Vascular Plants (WCVP), the taxonomic backbone used
by Plants of the World Online (POWO).

The process of accessing data from the original publication can pose
challenges for researchers, particularly due to the large number of taxa
presented within it. The `redbookperu` package has the primary objective
of addressing these challenges by providing updated taxonomic
information. Additionally, it introduces functions designed to enhance
the accessibility and usefulness of the data presented in the Red Book
of Endemic Plants of Peru.

The historical name printed in the Red Book is retained in
`redbook_name`. Current accepted names, authors, families, WCVP
identifiers, and taxonomic status are stored separately. This preserves
the source identity while allowing queries with current names and
synonyms.

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

The bundled data can be used without installing the optional `wcvpmatch`
and `arrow` packages. When available, `wcvpmatch` provides the preferred
parser and `arrow` reads the bundled Parquet catalogue; the legacy
parser and `.rda` data remain fallbacks.

### Getting Started

After installing the `redbookperu` package, you can load it into your R
session using:

``` r

library(redbookperu)
```

To determine whether a submitted name maps to a taxon in the Red Book,
use
[`check_redbooklist()`](https://paulesantos.github.io/redbookperu/reference/check_redbooklist.md).
The function preserves one output value per input name and reports
endemicity through historical names, accepted names, and synonyms.

``` r


splist <- c("Aphelandra cuscoensis", "Sanchezia capitata",
            "Sanchezia ovata", "Verbesina andinaa",
            "Persea americana", NA)

redbookperu::check_redbooklist(splist, dist = 0.2, quiet = TRUE)
#> [1] "endemic"     "endemic"     "endemic"     "endemic"     "not endemic"
#> [6] NA
```

Exact, fuzzy, and synonym matches to a Red Book record return
`"endemic"`; valid names without a Red Book record return
`"not endemic"`; invalid inputs return `NA_character_`.
`Sanchezia ovata` is the current accepted name associated with the
historical Red Book record `Sanchezia capitata`. Invalid inputs such as
`NA` or empty strings are preserved in the output and returned as
`NA_character_`, which keeps row-wise workflows aligned with the input
data.

[`check_redbooklist()`](https://paulesantos.github.io/redbookperu/reference/check_redbooklist.md)
function is designed to work seamlessly with tibble, allowing users to
easily analyze species data within a tabular format.

``` r

tibble::tibble(splist = splist) |> 
  dplyr::mutate(endemic = redbookperu::check_redbooklist(splist,
                                                         dist = 0.2,
                                                         quiet = TRUE))
#> # A tibble: 6 x 2
#>   splist                endemic    
#>   <chr>                 <chr>      
#> 1 Aphelandra cuscoensis endemic
#> 2 Sanchezia capitata    endemic    
#> 3 Sanchezia ovata       endemic
#> 4 Verbesina andinaa     endemic
#> 5 Persea americana      not endemic
#> 6 <NA>                  <NA>
```

For auditable workflows, use
[`match_redbook_names()`](https://paulesantos.github.io/redbookperu/reference/match_redbook_names.md)
to return one row per submitted name with the matched Red Book name,
accepted taxonomic name, endemicity status, match type, edit distance,
and candidate diagnostics.

``` r

redbookperu::match_redbook_names(c("Sanchezia ovata",
                                   "Verbesina andinaa",
                                   "Persea americana",
                                   NA),
                                 dist = 0.2,
                                 output = "summary")
#>   input_index    name_submitted input_valid redbook_id       redbook_name
#> 1           1   Sanchezia ovata        TRUE     32SACA Sanchezia capitata
#> 2           2 Verbesina andinaa        TRUE    979VEAN   Verbesina andina
#> 3           3  Persea americana        TRUE       <NA>               <NA>
#> 4           4              <NA>       FALSE       <NA>               <NA>
#>     accepted_name   matched_via name_update_status endemic_status  match_status
#> 1 Sanchezia ovata accepted_name       updated_name        endemic         exact
#> 2            <NA>  redbook_name    historical_name        endemic         fuzzy
#> 3            <NA>          <NA>               <NA>    not_endemic      no_match
#> 4            <NA>          <NA>               <NA>  invalid_input invalid_input
#>   match_distance
#> 1              0
#> 2              1
#> 3             NA
#> 4             NA
```

The detailed output includes `matched_via`, `name_update_status`,
`taxon_status`, `accepted_name`, and `accepted_family`, so a current
name matched through synonymy can be distinguished from a historical or
fuzzy match.

If you intend to access the information provided for each of the species
listed in the Red Book of Endemic Plants of Peru, you have the option to
use the
[`get_redbook_data()`](https://paulesantos.github.io/redbookperu/reference/get_redbook_data.md)
function. This function facilitates the association of updated taxonomic
information with the details concerning conservation status,
distribution, and descriptions presented in the original publication.

``` r

redbookperu::get_redbook_data(c("Sanchecia capitata",
                   "Weinmania nubigena",
                   "Macroclinium christensonii",
                   "Weberbauera violacea"), 
                   dist = 0.2,
                   unmatched = "placeholder",
                   quiet = TRUE)
#>               name_submitted              name_subitted
#> 1         Sanchecia capitata         Sanchecia capitata
#> 2         Weinmania nubigena         Weinmania nubigena
#> 3 Macroclinium christensonii Macroclinium christensonii
#> 4       Weberbauera violacea       Weberbauera violacea
#>                accepted_name accepted_name_author accepted_family
#> 1            Sanchezia ovata          Ruiz & Pav.     Acanthaceae
#> 2          Werneria nubigena                Kunth      Asteraceae
#> 3 Macroclinium christensonii            D.E.Benn.     Orchidaceae
#> 4       Weberbauera violacea           Al-Shehbaz    Brassicaceae
#>                            redbook_name        iucn
#> 1                    Sanchezia capitata          DD
#> 2 Werneria orbignyana var. breviradiata          DD
#> 3            Macroclinium christensonii CR, B1abiii
#> 4                  Weberbauera violacea          DD
#>                                   publication
#> 1 Bull. Herb. Boissier, ser. 2, 4: 315. 1904.
#> 2        Proc. Amer. Acad. Arts 5: 139. 1861.
#> 3    Brittonia 46(3): 249 - 251, f. 13. 1994.
#> 4         Novon 14(3): 266 - 268, f. 3. 2004.
#>                              collector herbariums  common_name dep_registry
#> 1                  A. Mathews 1230 (K)        --- Desconocido.      JU - PA
#> 2          C. Wilkes, Exped. Expl. US.        US. Desconocido.           HU
#> 3 O. del Castillo ex D.E. Bennett 5160        NY. Desconocido.           JU
#> 4 A. Sag<U+00E1>stegui A. et al. 11175  MO; HUT!. Desconocido.           CA
#>                ecological_regions      sinampe peruvian_herbariums
#> 1 BMHP, BHA; altitud desconocida. Sin registro            Ninguno.
#> 2       PSH; altitud desconocida. Sin registro            Ninguno.
#> 3                   BMHM; 1800 m. Sin registro            Ninguno.
#> 4                    PAR; 3800 m. Sin registro      HUT (isotipo).
#>                                                                                                                                                                                                                                                                                                     remarks
#> 1                                                  Esta especie arbustiva es conocida de dos localidades. La colecci<U+00F3>n tipo fue recolectada en la cuenca del Pangoa en el siglo XVIII. Probablemente la expansi<U+00F3>n urbana y las actividades agr<U+00ED>colas sean problemas para esta especie.
#> 2                                                                                                                                                                            Hierba aparentemente conocida s<U+00F3>lo de la colecci<U+00F3>n tipo, recolectada en una subcuenca alta del Mantaro, en 1839.
#> 3 Esta hierba ep<U+00ED>fita es conocida s<U+00F3>lo de la colecci<U+00F3>n tipo, proveniente del valle de Chanchamayo, en una subcuenca del Peren<U+00E9>. Esta regi<U+00F3>n ha sufrido continuas reducciones de sus <U+00E1>reas naturales debido a la ampliaci<U+00F3>n de la frontera agr<U+00ED>cola.
#> 4                                                                                                      Esta hierba paramuna es conocida de la localidad tipo, en la cuenca del Crisnejas, un tributario del Mara<U+00F1><U+00F3>n. El ejemplar tipo fue recolectado en 1983, de una jalca poco herborizada.
```

Missing values from
[`get_redbook_data()`](https://paulesantos.github.io/redbookperu/reference/get_redbook_data.md)
are `NA` by default. The historical `"---"` representation remains
available with `unmatched = "placeholder"`.

### Taxonomy update workflow

The reproducible update script is
[`data-raw/update_taxonomy.R`](https://paulesantos.github.io/redbookperu/data-raw/update_taxonomy.R).
It runs
[`wcvpmatch::classify_spnames()`](https://paulesantos.github.io/wcvpmatch/reference/classify_spnames.html)
followed by `wcvpmatch::wcvp_matching(allow_duplicates = TRUE)` for
every historical `redbook_name`, joins accepted WCVP IDs to the WCVP
backbone to recover the accepted family, and writes
`inst/extdata/redbook_taxonomy.parquet`, the fallback
`data/redbook_tab.rda`, and a dated snapshot under
`data-raw/snapshots/`. See the [taxonomy update
plan](https://paulesantos.github.io/redbookperu/specs/taxonomy-update-plan.md)
for the periodic tasks and data contract.
