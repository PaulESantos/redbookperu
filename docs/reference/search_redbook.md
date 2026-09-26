# Search Species Names in “The Red Book of Endemic Plants of Peru”

This function allows searching for plant taxa names listed in "The Red
Book of Endemic Plants of Peru". It connects to the data listed in the
catalog and validates if the species is present, removing orthographic
errors in plant names.

## Usage

``` r
search_redbook(
  splist,
  max_distance = 0.2,
  show_correct = FALSE,
  genus_fuzzy = FALSE,
  grammar_check = FALSE,
  progress_bar = show_progress()
)
```

## Arguments

- splist:

  A character vector specifying the input taxon, each element including
  genus and specific epithet and, potentially, infraspecific rank,
  infraspecific name, and author name. Only valid characters are allowed
  (see [`base::validEnc`](https://rdrr.io/r/base/validUTF8.html)).

- max_distance:

  An integer or fraction specifying the maximum distance allowed when
  comparing the submitted name with the closest name matches in the
  species listed in "The Red Book of Endemic Plants of Peru". The
  distance used is a generalized Levenshtein distance indicating the
  total number of insertions, deletions, and substitutions allowed to
  match the two names. For example, a name with a length of 10 and a
  max_distance = 0.1 allows only one change (insertion, deletion, or
  substitution). A max_distance = 2 allows two changes.

- show_correct:

  If TRUE, a column is added to the final result indicating whether the
  binomial name was exactly matched (TRUE) or if it is misspelled
  (FALSE).

- genus_fuzzy:

  If TRUE, allows fuzzy matching at the genus level.

- grammar_check:

  If TRUE, performs a grammar check on the species names.

## Value

A data frame with the matched species names and additional information
from the redbook catalog. If no match is found, a warning is issued
suggesting to increase the `max_distance` argument.

## Details

The function tries to match names in "The Red Book of Endemic Plants of
Peru", which has a corresponding accepted valid name (accepted_name). If
the input name is a valid name, it will be duplicated in the
accepted_name column.

The algorithm will first try to exactly match the binomial names
provided in `splist`. If no match is found, it will try to find the
closest name given the maximum distance defined in `max_distance`. Note
that only binomial names with valid characters are allowed in this
function.

## References

León, Blanca, et.al. 2006. “The Red Book of Endemic Plants of Peru”.
Revista Peruana De Biología 13 (2): 9s-22s.
https://doi.org/10.15381/rpb.v13i2.1782.
