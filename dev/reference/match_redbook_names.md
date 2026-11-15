# Match Submitted Names Against the Red Book of Endemic Plants of Peru

`match_redbook_names()` returns one row per submitted name with matching
diagnostics, endemicity status, and taxonomic context from the bundled
Red Book data.

## Usage

``` r
match_redbook_names(
  splist,
  dist = 0.1,
  method = "osa",
  parser = c("wcvpmatch", "legacy"),
  allow_duplicates = TRUE,
  output = c("detailed", "summary")
)
```

## Arguments

- splist:

  A character vector of submitted taxon names.

- dist:

  Maximum allowed edit distance for fuzzy matching. Values between 0 and
  1 are interpreted as a fraction of the submitted name length.

- method:

  Distance method. Currently only base R Levenshtein distance is used
  internally; the argument is reserved for compatibility with the
  planned `wcvpmatch` integration.

- parser:

  Parser preference. `"legacy"` uses the bundled parser. `"wcvpmatch"`
  uses
  [`wcvpmatch::classify_spnames()`](https://paulesantos.github.io/wcvpmatch/reference/classify_spnames.html)
  when available and falls back to the legacy parser otherwise.

- allow_duplicates:

  Logical. Kept for API compatibility; duplicated inputs are preserved
  in all cases.

- output:

  Output detail level. `"detailed"` returns the full diagnostic table.
  `"summary"` returns a compact subset.

## Value

A tibble with one row per input name.

## Examples

``` r
# Accepted name, spelling error, absent name, and missing input.
submitted <- c("Sanchezia ovata", "Verbesina andinaa",
               "Persea americana", NA_character_)
matches <- match_redbook_names(submitted, dist = 0.2,
                               parser = "legacy", output = "summary")
matches[, c("name_submitted", "input_valid", "redbook_name",
            "endemic_status", "match_status", "match_distance")]
#> # A tibble: 4 × 6
#>   name_submitted    input_valid redbook_name       endemic_status match_status 
#>   <chr>             <lgl>       <chr>              <chr>          <chr>        
#> 1 Sanchezia ovata   TRUE        Sanchezia capitata endemic        exact        
#> 2 Verbesina andinaa TRUE        Verbesina andina   endemic        fuzzy        
#> 3 Persea americana  TRUE        NA                 not_endemic    no_match     
#> 4 NA                FALSE       NA                 invalid_input  invalid_input
#> # ℹ 1 more variable: match_distance <dbl>

# Inspect the taxonomic context and how an accepted name was matched.
details <- match_redbook_names("Sanchezia ovata", parser = "legacy")
details[, c("name_submitted", "redbook_name", "accepted_name",
            "matched_via", "name_update_status")]
#> # A tibble: 1 × 5
#>   name_submitted  redbook_name      accepted_name matched_via name_update_status
#>   <chr>           <chr>             <chr>         <chr>       <chr>             
#> 1 Sanchezia ovata Sanchezia capita… Sanchezia ov… accepted_n… updated_name      
```
