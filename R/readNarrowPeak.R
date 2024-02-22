#' @title Extract narrow regions and peaks from a narrrowPeak file
#'
#' @description Read a narrowPeak file and extract the narrow regions and/or
#' the peaks, as specified by used. The narrowPeak file must fit the
#' UCSC specifications. See
#' \url{https://genome.ucsc.edu/FAQ/FAQformat.html#format12} for more
#' details. The file can have one or many header lines. However, the
#' total number of header lines must be inferior to 250 lines.
#'
#' @param file_path the name of the file.
#' @param extractRegions a \code{logical} indicating if the narrow regions must
#' be extracted. If \code{TRUE}, a \code{GRanges} containing the
#' narrow regions will be returned. Otherwise, \code{NULL} is
#' returned. Default = \code{TRUE}.
#' @param extractPeaks a \code{logical} indicating if the peaks must
#' be extracted. If \code{TRUE}, a \code{GRanges} containing the peaks
#' will be returned. Otherwise, \code{NULL} is
#' returned. Default = \code{TRUE}.
#'
#' @return a \code{list} containing 2 entries:
#' \itemize{
#' \item narrowPeak a {\code{GRanges}} containing
#' the narrow regions extracted from the file. {\code{NULL}} when
#' not needed by user.
#' \item peak a {\code{GRanges}} containing
#' the peaks extracted from the file. {\code{NULL}} when not
#' }
#'
#' @examples
#'
#' ## Set file information
#' test_narrowPeak <- system.file("extdata",
#'             "A549_FOSL2_ENCSR000BQO_MZW_part_chr_1_and_12.narrowPeak",
#'             package = "consensusSeekeR")
#'
#' ## Read file to extract peaks and regions
#' data <- readNarrowPeakFile(test_narrowPeak, extractRegions = TRUE,
#'             extractPeaks = TRUE)
#'
#' ## To access peak data (GRanges format)
#' head(data$peak)
#'
#' ## To access region data (GRanges format)
#' head(data$narrowPeak)
#'
#' @author Astrid Deschênes
#' @import BiocGenerics S4Vectors IRanges GenomicRanges
#' @importFrom rtracklayer import
#' @encoding UTF-8
#' @export
readNarrowPeakFile<- function(file_path, extractRegions = TRUE,
                                extractPeaks = TRUE) {
    # Parameters validation
    if (!file.exists(file_path)) {
        stop("No such file \"", file_path, "\"")
    }

    if (!is.logical(extractRegions)) {
        stop("extractRegions must be a logical value")
    }

    if (!is.logical(extractPeaks)) {
        stop("extractPeaks must be a logical value")
    }

    if (!extractRegions && !extractPeaks) {
        stop("extractPeaks and extractRegions cannot be both FALSE")
    }

    ### Specify informations about the extr columns
    extraCols <- c(signalValue = "numeric", pValue = "numeric",
                    qValue = "numeric", peak = "integer")

    ### Extract GRanges for narrowPeak regions from files
    regionResult <- import(file_path, format = "BED", extraCols = extraCols)

    peakResult <- NULL

    # Create GRanges for the peaks when specified
    if (extractPeaks) {
        peakResult          <- regionResult
        ranges(peakResult)  <- IRanges(start = (start(regionResult) +
                                    regionResult$peak),
                                    width = rep(1, length(regionResult$peak)))
    }

    # Create GRanges for the narrow regions when specified
    if (! extractRegions) {
        regionResult <- NULL
    }

    return(list(narrowPeak = regionResult, peak = peakResult))
}
