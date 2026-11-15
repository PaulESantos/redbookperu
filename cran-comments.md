## R CMD check results

0 errors | 0 warnings | 0 notes

This resubmission addresses the incoming pre-test NOTE for version 0.1.0:

* Removed `wcvpdata` from `Suggests`; it is used only by a `data-raw` script
  excluded from the source package.
* Removed `VignetteBuilder` and the unused vignette dependencies because the
  package contains no vignettes.
* Updated the redirected and inaccessible documentation URLs.

`R CMD check --as-cran` on Windows completed with status OK.
