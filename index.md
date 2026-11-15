# redbookperu [![](reference/figures/redbookperu_logo.png)](https://github.com/PaulESantos/redbookperu)

`redbookperu` facilita la consulta de los taxones incluidos en el *Libro
Rojo de las Plantas Endémicas del Perú* (León et al., 2006). Permite
comprobar si una lista de nombres científicos corresponde a un taxón
registrado como endémico y recuperar su información de conservación y
distribución.

El paquete conserva el nombre histórico publicado en el Libro Rojo y
ofrece, cuando está disponible, el nombre taxonómico aceptado. Las
búsquedas admiten nombres históricos, nombres aceptados, sinónimos y
errores ortográficos menores.

## Instalación

Instale la versión publicada desde CRAN:

``` r

install.packages("redbookperu")
```

O la versión de desarrollo desde GitHub:

``` r

pak::pak("PaulESantos/redbookperu")
```

Luego cargue el paquete:

``` r

library(redbookperu)
```

``` R
## This is redbookperu 0.1.0
```

## Uso

### Comprobar endemicidad

[`check_redbooklist()`](https://paulesantos.github.io/redbookperu/reference/check_redbooklist.md)
devuelve un estado para cada nombre enviado. Es útil para añadir una
columna de endemicidad a una tabla de trabajo.

``` r

species <- c("Aphelandra cuscoensis", "Sanchezia ovata", "Persea americana")

check_redbooklist(species, quiet = TRUE)
```

``` R
## [1] "endemic"     "endemic"     "not endemic"
```

``` r

#
# tibble
tibble::tibble(species = c("Aphelandra cuscoensis",
                           "Sanchezia ovata", 
                           "Persea americana")) |> 
  dplyr::mutate(endemic = check_redbooklist(species))
```

``` R
## Total exact matches: 1

## Total fuzzy matches: 1

## # A tibble: 3 × 2
##   species               endemic    
##   <chr>                 <chr>      
## 1 Aphelandra cuscoensis endemic    
## 2 Sanchezia ovata       endemic    
## 3 Persea americana      not endemic
```

### Recuperar la ficha de los taxones

[`get_redbook_data()`](https://paulesantos.github.io/redbookperu/reference/get_redbook_data.md)
devuelve un tibble con la información del Libro Rojo para cada nombre
consultado. Los nombres no encontrados se conservan y sus campos de
información se representan como valores ausentes.

``` r

get_redbook_data(
  c("Sanchezia ovata", "Macroclinium christensonii", "Persea americana"),
  quiet = TRUE
)
```

``` R
##               name_submitted              name_subitted
## 1            Sanchezia ovata            Sanchezia ovata
## 2 Macroclinium christensonii Macroclinium christensonii
## 3           Persea americana           Persea americana
##                accepted_name accepted_name_author accepted_family
## 1            Sanchezia ovata          Ruiz & Pav.     Acanthaceae
## 2 Macroclinium christensonii            D.E.Benn.     Orchidaceae
## 3                       <NA>                 <NA>            <NA>
##                 redbook_name        iucn
## 1         Sanchezia capitata          DD
## 2 Macroclinium christensonii CR, B1abiii
## 3                       <NA>        <NA>
##                                   publication
## 1 Bull. Herb. Boissier, ser. 2, 4: 315. 1904.
## 2    Brittonia 46(3): 249 - 251, f. 13. 1994.
## 3                                        <NA>
##                              collector herbariums  common_name dep_registry
## 1                  A. Mathews 1230 (K)       <NA> Desconocido.      JU - PA
## 2 O. del Castillo ex D.E. Bennett 5160        NY. Desconocido.           JU
## 3                                 <NA>       <NA>         <NA>         <NA>
##                ecological_regions      sinampe peruvian_herbariums
## 1 BMHP, BHA; altitud desconocida. Sin registro            Ninguno.
## 2                   BMHM; 1800 m. Sin registro            Ninguno.
## 3                            <NA>         <NA>                <NA>
##                                                                                                                                                                                                                                             remarks
## 1               Esta especie arbustiva es conocida de dos localidades. La colección tipo fue recolectada en la cuenca del Pangoa en el siglo XVIII. Probablemente la expansión urbana y las actividades agrícolas sean problemas para esta especie.
## 2 Esta hierba epífita es conocida sólo de la colección tipo, proveniente del valle de Chanchamayo, en una subcuenca del Perené. Esta región ha sufrido continuas reducciones de sus áreas naturales debido a la ampliación de la frontera agrícola.
## 3                                                                                                                                                                                                                                              <NA>
```

### Revisar cómo se resolvió cada nombre

Cuando sea importante auditar una búsqueda, use
[`match_redbook_names()`](https://paulesantos.github.io/redbookperu/reference/match_redbook_names.md).
El resultado es un tibble con una fila por nombre de entrada e indica,
entre otros datos, el nombre del Libro Rojo que se encontró, el estado
de coincidencia y la distancia de edición.

``` r

match_redbook_names(
  c("Sanchezia ovata", "Verbesina andinaa", "Persea americana"),
  dist = 0.2
)
```

``` R
##   input_index    name_submitted input_valid invalid_reason standardized_name
## 1           1   Sanchezia ovata        TRUE           <NA>   Sanchezia ovata
## 2           2 Verbesina andinaa        TRUE           <NA> Verbesina andinaa
## 3           3  Persea americana        TRUE           <NA>  Persea americana
##   redbook_id       redbook_name   accepted_name accepted_family
## 1     32SACA Sanchezia capitata Sanchezia ovata     Acanthaceae
## 2    979VEAN   Verbesina andina            <NA>            <NA>
## 3       <NA>               <NA>            <NA>            <NA>
##   accepted_name_author taxon_status   matched_via name_update_status
## 1          Ruiz & Pav.      synonym accepted_name       updated_name
## 2                 <NA>     unplaced  redbook_name    historical_name
## 3                 <NA>         <NA>          <NA>               <NA>
##   endemic_status match_status   match_stage match_distance candidate_count
## 1        endemic        exact    exact_name              0               1
## 2        endemic        fuzzy fuzzy_species              1               1
## 3    not_endemic     no_match          none             NA               0
##   ambiguous_candidates
## 1                 <NA>
## 2                 <NA>
## 3                 <NA>
```

Las funciones que generan resultados tabulares devuelven tibbles, por lo
que se integran directamente con flujos de trabajo basados en `dplyr` y
`tidyr`.

## Referencia

León, B., Roque, J., Ulloa Ulloa, C., Jørgensen, P. M., Pitman, N. y
Cano, A. (2006). *El Libro Rojo de las Plantas Endémicas del Perú*.
Revista Peruana de Biología, 13(2), 9s–22s.
<https://doi.org/10.15381/rpb.v13i2.1782>
