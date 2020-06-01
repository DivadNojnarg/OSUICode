shinyInputLabel <- function(inputId, label = NULL) {
  tags$label(label, class = "control-label", class = if (is.null(label)) {
    "shiny-label-null"
  }, `for` = inputId)
}

# dropNulls
dropNulls <- function(x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


# Given a Shiny tag object, process singletons and dependencies. Returns a list
# with rendered HTML and dependency objects.
processDeps <- function(tags, session) {
  ui <- takeSingletons(tags, session$singletons, desingleton=FALSE)$ui
  ui <- surroundSingletons(ui)
  dependencies <- lapply(
    resolveDependencies(findDependencies(ui)),
    createWebDependency
  )
  names(dependencies) <- NULL

  list(
    html = doRenderTags(ui),
    deps = dependencies
  )
}
