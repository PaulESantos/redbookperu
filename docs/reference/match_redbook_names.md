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

A data frame with one row per input name.
