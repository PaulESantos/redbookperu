
.onAttach <- function(lib, pkg) {
  packageStartupMessage("This is redbookperu ",
                        utils::packageDescription("redbookperu",
                                                  fields = "Version"
                        ),
                        appendLF = TRUE
  )
}


# -------------------------------------------------------------------------

show_progress <- function() {
  isTRUE(getOption("redbookperu.show_progress")) && # user disables progress bar
    interactive() # Not actively knitting a document
}



.onLoad <- function(libname, pkgname) {
  opt <- options()
  opt_redbookperu <- list(
    redbookperu.show_progress = TRUE
  )
  to_set <- !(names(opt_redbookperu) %in% names(opt))
  if (any(to_set)) options(opt_redbookperu[to_set])
  invisible()
}


# -------------------------------------------------------------------------
