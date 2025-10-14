#' @title Parameter validation for the \code{\link{findConsensusPeakRegions}}
#' function
#'
#' @description Validation of all parameters needed by the public
#' \code{\link{findConsensusPeakRegions}} function.
#'
#' @param narrowPeaks a \code{GRanges} representing called peaks of signal
#' for all experiments.
#'
#' @param peaks a \code{GRanges} representing peaks for all experiments.
#'
#' @param chrList a \code{Seqinfo} containing the name and the length of the
#' chromosomes to analyze which indicate that all chromosomes must
#' be analyzed.
#'
#' @param extendingSize a \code{numeric} value indicating the size of padding
#' at each side of the peaks median position to create the consensus
#' region. The minimum size of the consensus region will be equal to
#' twice the value of the \code{extendingSize} parameter. The size of
#' the \code{extendingSize} must be a positive integer. Default = 250.
#'
#' @param expandToFitPeakRegion a \code{logical} indicating if the region set
#' by the \code{extendingSize} parameter is extended to include all
#' region of the peak closest to the peaks median position for each
#' experiment.
#'
#' @param shrinkToFitPeakRegion a \code{logical} indicating if the region size,
#' which is set by the \code{extendingSize} parameter is shrinked to
#' fit the narrow peak regions of the peaks when all those regions
#' are smaller than the consensus region.
#'
#' @param minNbrExp a \code{numeric} indicating the minimum number of BED files
#' in which a peak must be present for a region to be retained. The numeric
#' must be a positive value inferior or equal to the number of files
#' present in the \code{narrowPeakFiles} parameter. Default = 1.
#'
#' @param nbrThreads a \code{numeric} indicating the number of threads to use
#' in parallel.
#'
#' @return \code{0} indicating that all parameters validations have been
#' successful.
#'
#' @examples
#'
#' ## Loading datasets
#' data(A549_FOSL2_01_NarrowPeaks_partial)
#' data(A549_FOXA1_01_NarrowPeaks_partial)
#' data(A549_FOSL2_01_Peaks_partial)
#' data(A549_FOXA1_01_Peaks_partial)
#'
#' ## Assigning experiment name to each row of the dataset.
#' ## NarrowPeak and Peak datasets from the same experiment must
#' ## have identical names.
#' names(A549_FOXA1_01_Peaks_partial) <- rep("FOXA1_01",
#'                         length(A549_FOXA1_01_Peaks_partial))
#' names(A549_FOXA1_01_NarrowPeaks_partial) <- rep("FOXA1_01",
#'                         length(A549_FOXA1_01_NarrowPeaks_partial))
#' names(A549_FOSL2_01_Peaks_partial) <- rep("FOSL2_01",
#'                         length(A549_FOSL2_01_Peaks_partial))
#' names(A549_FOSL2_01_NarrowPeaks_partial) <- rep("FOSL2_01",
#'                         length(A549_FOSL2_01_NarrowPeaks_partial))
#'
#' chrList <- Seqinfo("chr10", 135534747, NA)
#'
#' consensusSeekeR:::findConsensusPeakRegionsValidation(
#'     narrowPeaks = c(A549_FOXA1_01_NarrowPeaks_partial,
#'             A549_FOSL2_01_NarrowPeaks_partial),
#'     peaks = c(A549_FOXA1_01_Peaks_partial,
#'             A549_FOSL2_01_Peaks_partial),
#'     chrList = chrList,
#'     extendingSize = 110,
#'     expandToFitPeakRegion = FALSE,
#'     shrinkToFitPeakRegion = TRUE,
#'     minNbrExp = 2,
#'     nbrThreads = 1)
#'
#' @author Astrid Deschênes
#' @import Seqinfo
#' @importFrom methods is
#' @encoding UTF-8
#' @keywords internal
findConsensusPeakRegionsValidation <- function(narrowPeaks, peaks, chrList,
            extendingSize, expandToFitPeakRegion, shrinkToFitPeakRegion,
            minNbrExp, nbrThreads) {

    if (!is.logical(expandToFitPeakRegion)) {
        stop("expandToFitPeakRegion must be a logical value")
    }

    if (!is.logical(shrinkToFitPeakRegion)) {
        stop("shrinkToFitPeakRegion must be a logical value")
    }

    if (!is(peaks, "GRanges")) {
        stop("peaks must be a GRanges object")
    }

    if (length(peaks) < 1) {
        stop("peaks must be a GRanges object with at least one entry")
    }

    if (!is(chrList, "Seqinfo")) {
        stop("chrList must be a Seqinfo object")
    }

    if (expandToFitPeakRegion | shrinkToFitPeakRegion) {
        ## narrowPeaks is only validated when used by code
        if (!is(narrowPeaks, "GRanges")) {
            stop("narrowPeaks must be a GRanges object")
        }

        if (length(narrowPeaks) < 1) {
            stop("narrowPeaks must be a GRanges object with at least one entry")
        }

        if(length(narrowPeaks) != length(peaks)) {
            stop("narrowPeaks and peaks must have the same number of elements")
        }

        if(is.null(narrowPeaks$name) || is.null(peaks$name)) {
            stop("narrowPeaks and peaks must have defined metadata ",
                        "name so that each narrowPeaks entry can be ",
                        "associated to a peaks entry")
        }

        if(is.null(names(narrowPeaks)) || is.null(names(peaks))) {
            stop("narrowPeaks and peaks must have defined row names ",
                        "so that each entry can be associated to an ",
                        "experiment")
        }

        if (!all(sort(narrowPeaks$name) == sort(peaks$name)) ||
                !all(sort(names(narrowPeaks)) == sort(names(peaks)))) {
            stop("All narrowPeaks entry must have an equivalent peaks ",
                        "entry recognizable by both an identical metadata ",
                        "name and an identical row name")
        }
    }

    if (any(is.na(seqlengths(chrList)))) {
        stop("At least one chromosome length is missing in chrList")
    }

    if (!all(names(chrList) %in% names(seqinfo(peaks)))) {
        not_present <- names(chrList)[!(names(chrList)
                                        %in% names(seqinfo(peaks)))]
        if (length(not_present) == length(names(chrList))) {
            stop("No chromosome name from chrList is present in peak")
        }
    }

    if (!isInteger(extendingSize) || extendingSize < 1 ) {
        stop("extendingSize must be a non-negative integer")
    }

    if (!isInteger(minNbrExp) || minNbrExp < 1) {
        stop("minNbrExp must be a non-negative integer")
    }

    if (minNbrExp > length(unique(names(peaks)))) {
        stop("minNbrExp must be inferior or equal to the number ",
                    "of experiments presents in peaks. The number of",
                    "experiments is known by the number of differents ",
                    "row names in peaks.")
    }

    if (!isInteger(nbrThreads) || nbrThreads < 1 ) {
        stop("nbrThreads must be a non-negative integer")
    }

    return(0)
}

#' @title Validate if a value is an integer
#'
#' @description Validate if the value passed to the function is an integer or
#' not. To be considered as an integer, the value must have a length
#' of 1. The type of value can be a \code{integer} or \code{numerical}.
#' However, a \code{numerical} must have the same value
#' once casted to a \code{integer}.  A \code{vector} of
#' integers will returned \code{FALSE}.
#'
#' @param value an object to validate.
#'
#' @return \code{TRUE} is the parameter is a integer; otherwise \code{FALSE}
#'
#' @author Astrid Deschênes
#' @encoding UTF-8
#' @keywords internal
isInteger <- function(value) {
    result <- length(value) == 1

    if (result) {
        result <- (is.numeric(value)) && (as.integer(value) == value)
    }

    return(result)
}


#' @title Extract regions sharing features in more than one experiment for
#' one specific chromosome.
#'
#' @description Find regions sharing the same features for a minimum number of
#' experiments using called peaks of signal enrichment based on
#' pooled, normalized data (mainly coming from narrowPeak files). Tje
#' analysis is limited to one chromosome.
#' The peaks and narrow peaks are used to identify
#' the consensus regions. The minimum number of experiments that must
#' have at least on peak in a region so that it is retained as a
#' consensus region is specified by user, as well as the size of
#' mining regions.
#'
#' @param chrName a \code{character}, the name of the chromosome to analyze.
#'
#' @param allPeaks a \code{GRanges} containing all peaks from all experiments
#' sorted by position.
#'
#' @param allNarrowPeaks a \code{GRanges} containing all narrow peaks from all
#' experiments sorted by position.
#'
#' @param extendingSize a \code{numeric} value indicating the size of padding
#' at each side of the peaks median position to create the consensus
#' region. The minimum size of the consensu region will be equal to
#' twice the value of the \code{extendingSize} parameter. The size of
#' the \code{extendingSize} must be a positive integer. Default = 250.
#'
#' @param expandToFitPeakRegion a \code{logical} indicating if the region set by
#' the \code{extendingSize} parameter is extended to include all narrow peak
#' regions. Only the narrow peaks regions of the peaks included in the
#' unextended region are used during the extension process. It is possible
#' that has a side effect, adding peaks are being included in the
#' extended region.
#'
#' @param shrinkToFitPeakRegion a \code{logical} indicating if the region set
#' by the \code{extendingSize} parameter is shrinked to fit the narrow
#' peak regions.
#'
#' @param minNbrExp a \code{numeric} indicating the minimum number of BED files
#' in which a peak must be present for a region to be retained. The
#' numeric must be a positive value inferior or equal to the number
#' of files present in the \code{narrowPeakFiles} parameter. Default = 1.
#'
#' @param chrList a \code{Seqinfo} containing the name and the length of the
#' chromosomes to analyze.
#'
#' @return an object of \code{class} "commonFeatures".
#'
#' @author Astrid Deschênes
#' @import BiocGenerics IRanges Seqinfo GenomicRanges
#' @importFrom stringr str_split
#' @encoding UTF-8
#' @keywords internal
findConsensusPeakRegionsForOneChrom <- function(chrName, allPeaks,
                                                allNarrowPeaks, extendingSize,
                                                expandToFitPeakRegion,
                                                shrinkToFitPeakRegion,
                                                minNbrExp, chrList) {

    # Detect if narrowPeaks are needed or not
    areNarrowPeaksUsed <- expandToFitPeakRegion | shrinkToFitPeakRegion

    # Subset peaks using the specified chromosome name and retain only the
    # ranges
    peaksGRanges <- sort(subset(allPeaks,
                                as.character(seqnames(allPeaks)) == chrName))

    # Instead of using GRanges in the code, IRanges are used to
    # make the code faster
    peaks <- ranges(peaksGRanges)

    # Subset narrow peaks using the specified chromosome name
    if (areNarrowPeaksUsed) {
        narrowPeaks <- sort(subset(allNarrowPeaks,
                        as.character(seqnames(allNarrowPeaks)) == chrName))
    } else {
        narrowPeaks <- GRanges()
    }

    if (length(peaks) > 0) {

        # Get info for the specific chromosome
        chrInfo <- chrList[chrName]

        # GRanges containing final consensus peak regions
        maxLength <- 10000
        increment <- 10000

        regionsStartPos <- rep(1, maxLength)
        regionsEndPos   <- rep(1, maxLength)

        # The total number of consensus regions
        nbrRegions   <- 0L

        # The width of a consensus region
        region_width <- 2 * extendingSize

        # A default region is associated to each peak
        # The peak position is used as the starting position of the region
        # while the region width correspond to twice the extendingSize parameter
        peaksDefaultRanges <- IRanges(start = start(peaks),
                                width = rep(region_width + 1, length(peaks)))


        # Identify peaks that overlap each default region
        overlaps <- findOverlaps(query = peaksDefaultRanges, subject = peaks)

        # The current position of the last peak present in a selected region
        maxUsedPosition <- 0L

        for (pos in seq_len(length(peaks))) {

            # Only process peak not already present in retained regions
            if (pos <= maxUsedPosition) next

            currentPeak <- peaks[pos]

            # Extract peaks present in the default range
            # range : start(currentPeak) + 2 * extending_size
            setPeaks <- peaks[subjectHits(overlaps[which(queryHits(overlaps)
                                                            == pos)])]

            # Go through an iterative process to refine the selected range
            results <- refineRegion(peaks, setPeaks, extendingSize,
                                        region_width, currentPeak)

            # Process only when a region is found
            if (results$hasFoundRegion) {

                peaksInRegion <- results$peaksInRegion

                # Keep region only when the minimum number of different
                # experiments present is reached
                if (length(unique(names(peaksInRegion))) >= minNbrExp) {

                    # Create one final region using the narrow information
                    # for each peak present
                    minPos <- results$rightBoundary
                    maxPos <- minPos + region_width

                    if (areNarrowPeaksUsed) {
                        peakMatch <- IRanges::match(peaks, peaksInRegion,
                                                        nomatch = 0)
                        peaksGRangesInRegion <-
                                        peaksGRanges[as.logical(peakMatch)]

                        narrowPeaksSet <- narrowPeaks[narrowPeaks$name %in%
                                                    peaksGRangesInRegion$name]

                        minLeft <- min(start(narrowPeaksSet))
                        maxRight <- max(end(narrowPeaksSet))

                        if (expandToFitPeakRegion) {
                            if (minLeft < minPos) {
                                minPos <- minLeft
                            }
                            if (maxRight > maxPos) {
                                maxPos <- maxRight
                            }
                        }

                        if (shrinkToFitPeakRegion) {
                            if (minLeft > minPos) {
                                minPos <- minLeft
                            }
                            if (maxRight < maxPos) {
                                maxPos <- maxRight
                            }
                        }
                    }

                    # Validate that minimum position is not negative
                    if (minPos < 1) {
                        minPos <- 1
                    }

                    # Validate that maximum position is not
                    # superior to chromosome length
                    if (maxPos > seqlengths(chrInfo)) {
                        maxPos <- seqlengths(chrInfo)
                    }

                    # Update total number of consensus regions
                    nbrRegions <- nbrRegions + 1L

                    # Adapt size of GRanges containing final results
                    # when too many regions
                    if (nbrRegions > maxLength) {
                        regionsStartPos <- c(regionsStartPos, rep(1, maxLength))
                        regionsEndPos   <- c(regionsEndPos, rep(1, maxLength))
                        maxLength <- maxLength + increment
                    }

                    regionsStartPos[nbrRegions] <- minPos
                    regionsEndPos[nbrRegions]   <- maxPos

                    if (areNarrowPeaksUsed) {
                        newOverlaps <- which(start(peaks) >= minPos &
                                                        end(peaks) <= maxPos)
                        maxUsedPosition <- max(newOverlaps)
                    } else {
                        maxUsedPosition <- results$maxPosition
                    }
                }
            }
        }
    }

    # Adjust size of returned GRanges to the real number of consensus regions
    if (nbrRegions == 0) {
        regions <- GRanges()
    } else {
        regions <- GRanges(seqnames = rep(chrName, nbrRegions),
                        IRanges(start = regionsStartPos[seq_len(nbrRegions)],
                            end = regionsEndPos[seq_len(nbrRegions)]))
    }

    return(regions)
}


#' @title Refine the selected region by using an iterative process.
#'
#' @description Find regions sharing the same features for a minimum number of
#' experiments using called peaks of signal enrichment based on
#' pooled, normalized data (mainly coming from narrowPeak files). Tje
#' analysis is limited to one chromosome.
#' The peaks and narrow peaks are used to identify
#' the consensus regions. The minimum number of experiments that must
#' have at least on peak in a region so that it is retained as a
#' consensus region is specified by user, as well as the size of
#' mining regions.
#'
#' @param peaks a \code{GRanges} containing all peaks from the current analysis
#' sorted by position.
#'
#' @param setPeaks a \code{GRanges} containing the peaks present in the current
#' selected region.
#'
#' @param extendingSize a \code{numeric} value indicating the size of padding
#' at each side of the peaks median position to create the consensus
#' region. The minimum size of the consensu region will be equal to
#' twice the value of the \code{extendingSize} parameter. The size of
#' the \code{extendingSize} must be a positive integer.
#'
#' @param region_width a \code{numeric} value indicating the size of the
#' region which is equivalent to twice the \code{extendingSize}.
#'
#' @param currentPeak a \code{GRanges} with 1 range containing the information
#' about the current peak used as the starting point for the selected region.
#'
#' @return an object of \code{class} "commonFeatures".
#'
#' @author Astrid Deschênes
#' @import BiocGenerics IRanges GenomicRanges
#' @encoding UTF-8
#' @keywords internal
refineRegion <- function(peaks, setPeaks, extendingSize,
                                region_width, currentPeak) {

    hasFoundRegion <- TRUE
    setNewPeaks <- setPeaks
    rightBoundary <- NULL
    maxPosition <- NULL

    repeat {
        # Fix the current set of peaks using the previous obtained value
        setCurrentPeaks <- setNewPeaks

        # The updated region is centered on the median position of the peaks
        rightBoundary <- median(start(setCurrentPeaks)) - extendingSize

        # Create range to fit the updated region
        tempRange <- IRanges(start = rightBoundary,
                                    end = rightBoundary + region_width)

        # Get peaks present in the updated region
        overlaps <- findOverlaps(query = tempRange, subject = peaks)
        setNewPeaks <- peaks[subjectHits(overlaps)]

        # The peak used to select the region should always be present in the
        # updated region
        if (length(setNewPeaks) == 0 ||
                    !any(currentPeak == setNewPeaks)) {
            # The current peak is not included in the region
            # The region will not be selected and the iterative loop should be
            # stopped
            hasFoundRegion <- FALSE
            break
        }

        # Get the position of the righer most peak to ensure that
        # peaks won't be treated twice in the main iteration
        maxPosition <- max(subjectHits(overlaps))

        # Break out of the loop when the peaks presents in the regions are
        # stable
        if ((length(setNewPeaks) == length(setCurrentPeaks)) &&
                all(setCurrentPeaks == setNewPeaks)) break
    }

    return(list(hasFoundRegion = hasFoundRegion, peaksInRegion = setNewPeaks,
                rightBoundary = rightBoundary, maxPosition = maxPosition))
}
