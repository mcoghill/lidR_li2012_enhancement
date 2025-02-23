#' Individual Tree Detection Algorithm
#'
#' This function is made to be used in \link[lidR:locate_trees]{locate_trees}. It implements an
#' experimental algorithms for tree detection based on a several ideas from the litterature. First it
#' select the highest points in each cell of a 1 m grid to reduce the amount of data and considerably
#' improve speed, then it performs a local maximum filter to find tree tops. To finish it applies the
#' filtering rule from \link{multichm} (step (b))
#'
#' @param ws numeric or function. Length or diameter of the moving window used to the detect the local
#' maxima in the unit of the input data (usually meters). If it is numeric a fixed windows size is used.
#' If it is a function, the function determines the size of the window at any given location on the canopy.
#' The function should take the height of a given pixel or points as its only argument and return the
#' desired size of the search window when centered on that pixel/point.
#'
#' @param hmin numeric. Minimum height of a tree. Threshold below which a pixel or a point
#' cannot be a local maxima. Default 2.
#'
#' @param dist_2d numeric. 2D distance threshold. A local maximum is considered a detected tree
#' if there is no detected tree within this 2D distance.
#'
#' @export
#'
#' @examples
#' LASfile <- system.file("extdata", "MixedConifer.laz", package="lidR")
#' las = readLAS(LASfile)
#'
#' ttops = find_trees(las, lmfx(ws = 3))
#'
#' x = plot(las)
#' add_treetops3d(x, ttops)
lmfx = function(ws, hmin = 2, dist_2d = 3)
{
  f = function(las)
  {
    context <- tryCatch({get("lidR.context", envir = parent.frame())}, error = function(e) {return(NULL)})
    lidR:::assert_is_valid_context(lidR:::LIDRCONTEXTITD, name = "lmfx")

    . <- X <- Y <- Z <- treeID <- NULL

    dist_2d = dist_2d^2

    if (is.numeric(ws) & length(ws) == 1)
    {
      # nothing to do
    }
    else if (is.function(ws))
    {
      n  = npoints(las)
      ws = ws(las@data$Z)

      if (!is.numeric(ws)) stop("The function 'ws' did not return correct output. ", call. = FALSE)
      if (any(ws <= 0))    stop("The function 'ws' returned negative or nul values.", call. = FALSE)
      if (anyNA(ws))       stop("The function 'ws' returned NA values.", call. = FALSE)
      if (length(ws) != n) stop("The function 'ws' did not return correct output.", call. = FALSE)
    }
    else
      stop("'ws' must be a number or a function", call. = FALSE)

    . <- X <- Y <- Z <- treeID <- NULL
    las_dec = lidR::decimate_points(las, lidR::highest(1))
    lidR:::force_autoindex(las_dec) <- lidR:::LIDRGRIDPARTITION
    is_maxima = lidR:::C_lmf(las_dec, ws, hmin, TRUE, lidR:::getThread())
    LM = las_dec@data[is_maxima, .(X,Y,Z)]

    data.table::setorder(LM, -Z)

    detected = logical(nrow(LM))
    detected[1] = TRUE

    for (i in 2:nrow(LM))
    {
      distance2D = (LM$X[i] - LM$X[detected])^2 + (LM$Y[i] - LM$Y[detected])^2
      #distance3D = distance2D + (LM$Z[i] - LM$Z[detected])^2

      if (!any(distance2D < dist_2d))# & !any(distance3D < dist_3d))
      {
        detected[i] = TRUE
      }
    }

    detected = LM[detected, ][, treePres := TRUE]

    output = merge(las@data, detected, by = c("X", "Y", "Z"), all = TRUE)
    output$treePres[is.na(output$treePres)] <- FALSE
    return(output$treePres)
  }

  f <- plugin_itd(f, omp = TRUE, raster_based = FALSE)
  return(f)
}
